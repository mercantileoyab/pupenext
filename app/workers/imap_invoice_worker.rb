require 'fileutils'
require 'mail'
require 'securerandom'

USERNAME          = ARGV[0]
PASSWORD          = ARGV[1]
IMAP_SERVER       = ARGV[2]
SMPT_SERVER       = ARGV[3]
ALLOWED_DOMAIN    = ARGV[4]
ARCHIVE_DIRECTORY = ARGV[5]
SAVE_DIRECTORY    = ARGV[6]

class ImapInvoiceWorker

  def self.fetch_messages
    # Make sure we have everything
    exit unless valid_parameters?

    # Set options
    Mail.defaults do
      retriever_method :imap, address: IMAP_SERVER,
                              port: 993,
                              user_name: USERNAME,
                              password: PASSWORD,
                              enable_ssl: true
      delivery_method :smtp,  address: SMPT_SERVER,
                              port: 587,
                              user_name: USERNAME,
                              password: PASSWORD,
                              enable_ssl: true
    end

    # Loop all messages in inbox
    Mail.all do |message, connector, item_uid|
      # Process message
      process_message(message)

      # Move message to Archive
      connector.uid_copy(item_uid, ARCHIVE_DIRECTORY)

      # Mark message deleted in inbox
      connector.select("INBOX")
      connector.uid_store(item_uid, "+FLAGS", [:Deleted])
    end
  end

  def self.process_message(msg)
    # Allow msgs only from allowed domain
    if msg.from.first.end_with?("@#{ALLOWED_DOMAIN}")

      # Loop all attachments
      msg.attachments.each { |file| handle_file(msg, file) }

      if msg.attachments.empty?
        mail_options = {
          to: msg.from.first,
          from: USERNAME,
          subject: "Liitetiedoston vastaanotto epäonnistui!",
          body: "Otsikko: #{msg.subject}\nViestissä ei ollut liitetiedostoja!",
        }

        send_email mail_options
      end
    end
  end

  def self.handle_file(message, file)
    # Get all images/pdfs from messages attachments
    if file.content_type.start_with?('image/', 'application/pdf')
      boob = save_image(file.filename, file.body.decoded)
    else
      boob = false
    end

    msg = boob ? "onnistui" : "epäonnistui"

    mail_options = {
      to: message.from.first,
      from: USERNAME,
      subject: "Liitetiedoston vastaanotto #{msg}!",
      body: "Otsikko: #{message.subject}\nTiedosto: #{file.filename}",
      filename: file.filename,
      content: file.body.decoded
    }

    send_email mail_options
  end

  def self.save_image(name, data)
    # Prefix with random string
    prefix = SecureRandom.hex(15)

    # Filepath to SAVE_DIRECTORY
    dir = SAVE_DIRECTORY.dup
    dir.sub!(/\/+$/, '')

    fname = "#{dir}/#{prefix}-#{name.downcase.gsub(/[^a-z0-9\.\-]/, '').squeeze('.')}"

    # Save file
    begin
      f = File.open(fname, 'w+b')
      f.write data
      f.close
      true
    rescue Exception => e
      false
    end
  end

  # Send new email
  def self.send_email(options)
    mail = Mail.new do
      from options[:from]
      to options[:to]
      subject options[:subject]
      body options[:body]

      if options[:filename] && options[:content]
        add_file filename: options[:filename], content: options[:content]
      end
    end

    mail.charset = 'utf-8'
    mail.deliver
  end

  def self.valid_parameters?
    check = true
    check &= USERNAME
    check &= PASSWORD
    check &= IMAP_SERVER
    check &= SMPT_SERVER
    check &= ALLOWED_DOMAIN
    check &= ARCHIVE_DIRECTORY
    check &= SAVE_DIRECTORY
    check
  end

end