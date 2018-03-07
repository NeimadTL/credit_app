class ChangeRibKeyColumnTypeToString < ActiveRecord::Migration
  def change
    change_column :bank_accounts, :rib_key, :string
  end
end
