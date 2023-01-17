class AddFieldsToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :field1, :integer
    add_column :games, :field2, :integer
    add_column :games, :field3, :integer
    add_column :games, :field4, :integer
    add_column :games, :field5, :integer
    add_column :games, :field6, :integer
    add_column :games, :field7, :integer
    add_column :games, :field8, :integer
    add_column :games, :field9, :integer
  end
end
