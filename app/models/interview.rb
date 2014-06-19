class Interview < ActiveRecord::Base
  belongs_to :position
  has_many :interview_history_items, -> { order "history_datetime desc" }
  
  validates :position, presence: true
  validates :interview_datetime, presence: true
  validates :status_id, presence: true
  
  validate :only_one_active_interview
    
  after_initialize :set_status
  
  def set_status
    if self.status_id.nil?      
      self.status_id = InterviewStatus::NEW.id
    end
  end
  
  def status
    InterviewStatus.find_by_id(status_id)
  end
  
  def can_be_edited?
    status == InterviewStatus::NEW
  end
  
  def can_be_accepted_or_rejected_by_interviewee?
    status == InterviewStatus::INVITATION_SENT
  end
  
  def can_be_cancelled?
    status == InterviewStatus::INVITATION_SENT || status == InterviewStatus::INVITATION_ACCEPTED
  end
  
  def cancelled?
    status == InterviewStatus::CANCELLED
  end
  
  def completed?
    status == InterviewStatus::COMPLETED
  end
  
  def accepted?
    status == InterviewStatus::INVITATION_ACCEPTED
  end
  
  def dismissed?
    status == InterviewStatus::DISMISSED
  end
  
  def rejected?
    status == InterviewStatus::INVITATION_REJECTED
  end
  
  def active?
    InterviewStatus.active_statuses.include?(status)
  end
  
  private
  
  def only_one_active_interview
    return if !active?
    
    num_of_active_interviews_for_position = position.interviews.where(:status_id => InterviewStatus.active_statuses.map(&:id)).where("id != ?", id || -1).count
    
    if num_of_active_interviews_for_position > 0
      errors[:base] << "There can only be one active interview for a position. Please cancel or dismiss the existing active interview."
    end
  end
  
end