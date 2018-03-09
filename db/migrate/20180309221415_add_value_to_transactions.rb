class AddValueToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :value, :decimal, :default => 0
  end
end
