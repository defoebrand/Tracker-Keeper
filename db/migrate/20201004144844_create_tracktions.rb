class CreateTracktions < ActiveRecord::Migration[6.0]
  def change
    create_table :tracktions do |t|
      t.belongs_to :author, references: :users, null: false
      t.string :name
      t.float :amount
      t.belongs_to :type, null: false

      t.timestamps
    end
  end
end
