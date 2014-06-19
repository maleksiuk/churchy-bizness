class InterviewsController < ApplicationController
  skip_before_action :require_login, only: [:accept_or_reject, :accept, :reject]
  before_action :set_interview, only: [:show, :edit, :update, :cancel, :complete, :send_invitation, :accept_by_admin, :reject_by_admin, :dismiss]
  
  def index
    @interviews = Interview.includes(:position).order("interview_datetime desc").page(params[:page])
  end
  
  def show
  end
  
  def new
    @interview = Interview.new    
    @positions = Position.all
    
    if params[:position_id]
      @interview.position = Position.find(params[:position_id])
    else
      @interview.position = @positions.first
    end
  end
  
  def update_position_info
    @position = Position.find(params[:selected_position_id])
  end

  def edit
    @positions = Position.all
  end

  def create
    @interview = Interview.new(interview_params)
    
    if @interview.save
      InterviewHistoryItem.create_item(@interview, "Interview created.")
      redirect_to @interview, notice: 'Interview was successfully created.'
    else
      @positions = Position.all
      
      render action: 'new'
    end
  end

  def update
    if @interview.update(interview_params)
      InterviewHistoryItem.create_item(@interview, "Interview updated.")
      redirect_to @interview, notice: 'Interview was successfully updated.'
    else
      render action: 'edit'
    end
  end
  
  def cancel
    if @interview.update(:status_id => InterviewStatus::CANCELLED.id)
      InterviewHistoryItem.create_item(@interview, "Interview cancelled.")
      redirect_to @interview, notice: 'Interview was successfully cancelled.'
    else
      flash.now[:error] = "An error occurred while trying to update the status to cancelled."
      render action: 'show'
    end
  end
  
  def complete
    if @interview.update(:status_id => InterviewStatus::COMPLETED.id)
      InterviewHistoryItem.create_item(@interview, "Interview completed.")
      redirect_to @interview, notice: 'Interview was successfully completed.'
    else
      flash.now[:error] = "An error occurred while trying to update the status to completed."
      render action: 'show'
    end
  end
  
  def dismiss
    if @interview.update(:status_id => InterviewStatus::DISMISSED.id)
      InterviewHistoryItem.create_item(@interview, "Interview dismissed.")
      redirect_to @interview, notice: 'Interview was dismissed.'
    else
      flash.now[:error] = "An error occurred while trying to update the status to dismissed."      
      render action: 'show'
    end
  end
  
  def send_invitation
    @interview.update(:status_id => InterviewStatus::INVITATION_SENT.id, :email_key => SecureRandom.urlsafe_base64(16))    
    UserMailer.delay.interview_invitation_email(@interview)
    InterviewHistoryItem.create_item(@interview, "Invitation e-mail sent.")
    redirect_to(@interview, notice: 'Invitation was sent.')
  end
  
  def accept_or_reject
    @show_full_nav_bar = false
    
    @email_key = params[:key]
    @interview = Interview.where(:email_key => @email_key).first
    
    unless @interview && @interview.can_be_accepted_or_rejected_by_interviewee?
      render :cannot_accept_or_reject
    end
  end
  
  def accept
    @show_full_nav_bar = false
    @email_key = params[:key]
    @interview = Interview.where(:email_key => @email_key).first
    
    if @interview && @interview.can_be_accepted_or_rejected_by_interviewee? && @interview.update(:status_id => InterviewStatus::INVITATION_ACCEPTED.id)
      InterviewHistoryItem.create_item(@interview, "Invitation accepted.")
      UserMailer.delay.interview_acceptance_email(@interview)
    else
      render :cannot_accept_or_reject
    end
  end
  
  def reject
    @show_full_nav_bar = false
    @email_key = params[:key]
    @interview = Interview.where(:email_key => @email_key).first
    
    if @interview && @interview.can_be_accepted_or_rejected_by_interviewee? && @interview.update(:status_id => InterviewStatus::INVITATION_REJECTED.id)      
      rejection_message = params[:rejection_message] || ''
      InterviewHistoryItem.create_item(@interview, "Invitation rejected. Reason given: #{rejection_message[0...200]}")
      UserMailer.delay.interview_rejection_email(@interview, rejection_message)
    else
      render :cannot_accept_or_reject
    end
  end
  
  def accept_by_admin
    if @interview.update(:status_id => InterviewStatus::INVITATION_ACCEPTED.id)
      InterviewHistoryItem.create_item(@interview, "Interview manually accepted by administrator.")
      redirect_to @interview, notice: 'Interview was successfully accepted.'
    else
      flash.now[:error] = "An error occurred while trying to update the status to accepted."
      render action: 'show'
    end    
  end
  
  def reject_by_admin
    if @interview.update(:status_id => InterviewStatus::INVITATION_REJECTED.id)
      InterviewHistoryItem.create_item(@interview, "Interview manually rejected by administrator.")
      redirect_to @interview, notice: 'Interview was successfully rejected.'
    else
      flash.now[:error] = "An error occurred while trying to update the status to rejected."
      render action: 'show'
    end        
  end

  private
    
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:interview_datetime, :position_id)
    end
end
