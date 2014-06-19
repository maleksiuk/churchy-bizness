class InterviewHistoryItem < ActiveRecord::Base
  
  belongs_to :position
  belongs_to :interview
  
  def self.create_item(interview, message)
    InterviewHistoryItem.create(:history_datetime => DateTime.now, :interview => interview, :position => interview.position, :message => message)
  end
  
end