class CreateJoinTableGroupsTracktions < ActiveRecord::Migration[6.0]
  def change
    create_join_table :groups, :tracktions do |t|
    end
  end
end
