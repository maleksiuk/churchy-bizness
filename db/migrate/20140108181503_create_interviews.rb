class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.datetime :interview_datetime
      t.references :position
    end
  end
end
