class InterviewStatus
  
  def initialize(id, name)
    @id = id
    @name = name
  end
  
  NEW = InterviewStatus.new(1, "New")
  INVITATION_SENT = InterviewStatus.new(2, "Invitation Sent")
  INVITATION_ACCEPTED = InterviewStatus.new(3, "Invitation Accepted")
  INVITATION_REJECTED = InterviewStatus.new(4, "Invitation Rejected")
  
  COMPLETED = InterviewStatus.new(80, "Completed")
  CANCELLED = InterviewStatus.new(81, "Cancelled")
  DISMISSED = InterviewStatus.new(82, "Dismissed")
  
  @@statuses = [NEW, INVITATION_SENT, INVITATION_ACCEPTED, INVITATION_REJECTED, COMPLETED, CANCELLED, DISMISSED]
  
  def id
    @id
  end
  
  def name
    @name
  end
  
  def self.find_by_id(id)
    @@statuses.find { |s| s.id == id }
  end
  
  def self.active_statuses
    [NEW, INVITATION_SENT, INVITATION_ACCEPTED, INVITATION_REJECTED]
  end
  
end