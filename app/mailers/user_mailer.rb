class UserMailer < ActionMailer::Base
  
  def interview_invitation_email(interview)
    @interview = interview
    @user = interview.position.user
    @leader = interview.position.leader
    @admin_user = User.admin_user
    
    subject = "Stewardship Interview with #{@leader.name}, #{@interview.interview_datetime.to_formatted_s(:short_and_easy)}"
    
    mail(to: @user.email, from: @admin_user.email, cc: @admin_user.email, subject: subject)
  end
  
  def interview_acceptance_email(interview)
    @interview = interview
    @user = interview.position.user
    @leader = interview.position.leader
    @admin_user = User.admin_user
    
    subject = "#{@user.full_name} accepted interview with #{@leader.name} (#{@interview.interview_datetime.to_formatted_s(:short_and_easy)})"
    
    mail(to: @admin_user.email, from: @admin_user.email, cc: nil, subject: subject)    
  end
  
  def interview_rejection_email(interview, rejection_message)
    @interview = interview
    @user = interview.position.user
    @leader = interview.position.leader
    @admin_user = User.admin_user
    @rejection_message = rejection_message
    
    subject = "#{@user.full_name} rejected interview with #{@leader.name} (#{@interview.interview_datetime.to_formatted_s(:short_and_easy)})"
    
    mail(to: @admin_user.email, from: @admin_user.email, cc: nil, subject: subject)
  end
  
end
