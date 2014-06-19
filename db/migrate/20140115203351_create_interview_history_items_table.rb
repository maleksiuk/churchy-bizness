class CreateInterviewHistoryItemsTable < ActiveRecord::Migration
  def change
    create_table :interview_history_items do |t|
      t.datetime :history_datetime, :null => false
      t.references :position, :null => false
      t.references :interview, :null => false
      t.string :message, :null => false
    end
  end
end
