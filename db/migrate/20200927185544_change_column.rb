class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :transactions, :type, :amount_type
  end
end
