module ApplicationHelper
  
  def flash_class(level)
    case level
      when :notice then "alert alert-success"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-danger"
    end
  end
  
  def active_interview_status_text(interview)    
    class_name = if interview.status == InterviewStatus::NEW
      "label-primary"
    elsif interview.status == InterviewStatus::INVITATION_SENT
      "label-warning"
    elsif interview.status == InterviewStatus::INVITATION_ACCEPTED
      "label-success"
    elsif interview.status == InterviewStatus::INVITATION_REJECTED
      "label-danger"
    else
      "label-default"
    end
    
    "<span class='label #{class_name}'>#{interview.status.name}</span>".html_safe
  end
  
end
