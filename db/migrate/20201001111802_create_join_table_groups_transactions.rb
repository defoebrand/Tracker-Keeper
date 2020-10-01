class CreateJoinTableGroupsTransactions < ActiveRecord::Migration[6.0]
  def change
    create_join_table :groups, :transactions do |t|
      # t.index [:group_id, :transaction_id]
      # t.index [:transaction_id, :group_id]
    end
  end
end
