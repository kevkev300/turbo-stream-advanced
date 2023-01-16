class AddFieldsToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :field1, :string
    add_column :games, :field2, :string
    add_column :games, :field3, :string
    add_column :games, :field4, :string
    add_column :games, :field5, :string
    add_column :games, :field6, :string
    add_column :games, :field7, :string
    add_column :games, :field8, :string
    add_column :games, :field9, :string
  end
end
