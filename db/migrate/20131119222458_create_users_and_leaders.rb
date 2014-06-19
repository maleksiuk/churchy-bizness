class CreateUsersAndLeaders < ActiveRecord::Migration  
  def change    
    create_table :users do |t|
      t.string :username, :null => false
      t.string :name, :null => false
      t.string :email, :null => false
      
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false
    end
    
    add_index :users, :username, unique: true
    
    create_table :leaders do |t|
      t.string :name, :null => false
    end
  end
end
