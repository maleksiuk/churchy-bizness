class AddStatusColumnToInterviewsTable < ActiveRecord::Migration
  def change
    add_column :interviews, :status_id, :integer, :null => false
  end
end