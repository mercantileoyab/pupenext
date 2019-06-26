class AutomaattisetEpakurantoinnit < ActiveRecord::Migration
  def up
    add_column :yhtion_parametrit, :epakurantti_automaattimuutokset, :string, limit: 1, default: '', null: false, after: :epakurantoinnin_myyntihintaleikkuri
  end

  def down
    remove_column :yhtion_parametrit, :epakurantti_automaattimuutokset
  end
end
