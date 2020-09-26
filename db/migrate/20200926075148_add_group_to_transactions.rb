class AddGroupToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :group, foreign_key: true
  end
end
