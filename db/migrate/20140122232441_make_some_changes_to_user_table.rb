class MakeSomeChangesToUserTable < ActiveRecord::Migration
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string, :null => false
    add_column :users, :honorific, :string, :null => false
    add_column :users, :phone_number, :string, :null => false
  end
end