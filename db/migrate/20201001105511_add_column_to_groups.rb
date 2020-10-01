class AddColumnToGroups < ActiveRecord::Migration[6.0]
  def change
    add_reference :groups, :transaction, index: true, foreign_key: true
  end
end
