class AutomaattinenTulostusYhtionparameihin < ActiveRecord::Migration
  def change
    add_column :yhtion_parametrit, :noutotilausten_tulostus, :string, limit: 255, default: '', null: false, after: :siirtolistan_tulostustapa
  end
end
