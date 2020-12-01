class ToimEmailAsiakkaalle < ActiveRecord::Migration
  def up
    add_column :asiakas, :toim_email, :string, limit: 255, default: '', null: false, after: :talhal_email
  end

  def down
    remove_column :asiakas, :talhal_email
  end
end