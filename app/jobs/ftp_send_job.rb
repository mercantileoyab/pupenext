require 'net/ftp'

class FtpSendJob < ActiveJob::Base
  queue_as :ftp_send

  def perform(transport_id:, file:)
    raise "File '#{file}' not found" unless File.exist?(file)

    @transport = Transport.find transport_id
    @file = file

    send_file
  end

  private

    def send_file
      ftp = Net::FTP.new

      begin
        ftp.connect @transport.hostname
        ftp.login @transport.username, @transport.password
        ftp.chdir @transport.path
        ftp.put @file
        ftp.quit
      rescue => e
        message = "FTP Error: #{e.message}"

        STDERR.puts message
        Rails.logger.error message

        raise message
      ensure
        ftp.close
      end
    end
end
