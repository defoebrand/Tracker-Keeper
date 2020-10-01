class RemoveColumnsFromTables < ActiveRecord::Migration[6.0]
  def change
    remove_column :groups, :transaction_id
    remove_column :transactions, :group_id
  end
end
