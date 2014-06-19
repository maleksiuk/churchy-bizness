class AddKeyColumnToInterviewsTable < ActiveRecord::Migration
  def change
    add_column :interviews, :email_key, :string
  end
end