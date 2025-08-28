class MhkerroinTuote < ActiveRecord::Migration
  def change
    add_column :tuote, :mhkerroin, :decimal, precision: 10, scale: 2, null: true, after: :myyntihinta
  end
end