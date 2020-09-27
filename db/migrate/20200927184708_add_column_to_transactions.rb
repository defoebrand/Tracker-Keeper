class AddColumnToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :type, :string
  end
end
