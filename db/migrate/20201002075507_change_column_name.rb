class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :transactions, :user_id, :authorid
  end
end
