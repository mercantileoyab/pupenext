class AddSaapumisnumeroLasku < ActiveRecord::Migration
  def change
    add_column :lasku, :saapumisnumero, :string, limit: 255, default: '', null: false, after: :tunnus
  end
end