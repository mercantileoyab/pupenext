class TuotemerkkiAsiakasalennus < ActiveRecord::Migration
  def change
    add_column :asiakasalennus, :tuotemerkki, :string, limit: 255, null: true, after: :ryhma
  end
end