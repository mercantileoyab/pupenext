class AutoTulostinNoutoTilaukselleVarastoihin < ActiveRecord::Migration
  def change
    add_column :varastopaikat, :printteri11, :string, limit: 20, default: '', null: false, after: :printteri10
  end
end