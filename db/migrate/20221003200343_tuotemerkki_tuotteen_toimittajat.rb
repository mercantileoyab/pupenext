class TuotemerkkiTuotteenToimittajat < ActiveRecord::Migration
  def change
    add_column :tuotteen_toimittajat, :tuotemerkki, :string, limit: 255, default: '', null: false, after: :alkuperamaa
  end
end
