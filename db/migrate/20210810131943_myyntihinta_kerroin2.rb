class MyyntihintaKerroin2 < ActiveRecord::Migration
  def change
    add_column :toimi, :myyntihinta_kerroin, :decimal, precision: 16, scale: 6, default: 0.0, after: :kulujen_laskeminen_hintoihin
  end
end