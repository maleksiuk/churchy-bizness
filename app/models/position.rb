class Position < ActiveRecord::Base
  belongs_to :leader
  belongs_to :user
  has_many :interviews
  has_many :interview_history_items, -> { order "history_datetime desc" }
  
  has_one :active_interview, -> { where(:status_id => InterviewStatus.active_statuses.map(&:id)).limit(1) }, class_name: 'Interview'
  has_one :most_recent_completed_interview, -> { where(status_id: InterviewStatus::COMPLETED.id).order('interview_datetime desc').limit(1) }, class_name: 'Interview'
  
  validates :leader, presence: true
  validates :user, presence: true
  validates :name, presence: true
  validates :meeting_time, length: { maximum: 10 }
  
end