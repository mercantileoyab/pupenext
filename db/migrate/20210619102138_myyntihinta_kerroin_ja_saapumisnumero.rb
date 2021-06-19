class MyyntihintaKerroinJaSaapumisnumero < ActiveRecord::Migration
  def change
    add_column :lasku, :saapumisnumero, :string, limit: 255, default: '', null: false, after: :asiakkaan_tilausnumero
    add_column :tuotteen_toimittajat, :myyntihinta_kerroin, :decimal, precision: 16, scale: 6, default: 0.0, after: :tuotekerroin
  end
end