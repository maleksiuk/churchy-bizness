class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name, :null => false
      t.references :leader, :null => false
      t.references :user, :null => false
    end
  end
end
