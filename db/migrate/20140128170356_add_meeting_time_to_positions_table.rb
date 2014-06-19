class AddMeetingTimeToPositionsTable < ActiveRecord::Migration
  def change
    add_column :positions, :meeting_time, :string, :limit => 10
  end
end