module InterviewsHelper
  
  def should_show_send_invitation_button(interview)
    interview.status == InterviewStatus::NEW || interview.status == InterviewStatus::INVITATION_SENT
  end
  
  def send_invitation_button_text(interview)
    interview.status == InterviewStatus::INVITATION_SENT ? 'Re-send invitation e-mail' : 'Send invitation e-mail'
  end
  
end
