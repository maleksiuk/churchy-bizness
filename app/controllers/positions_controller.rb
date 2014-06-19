class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update]
  
  def index
    @leader = if params[:leader_id]
      Leader.find(params[:leader_id])
    else
      Leader.first
    end
    
    @positions = @leader.positions.includes(:active_interview)
    
    @positions = if params[:sort] == PositionsHelper::COMPLETED_DESC
      @positions.sort_by { |p| p.most_recent_completed_interview.nil? ? DateTime.new(2300, 1, 1) : p.most_recent_completed_interview.interview_datetime }.reverse        
    elsif params[:sort] == PositionsHelper::COMPLETED_ASC
      @positions.sort_by { |p| p.most_recent_completed_interview.nil? ? DateTime.new(2300, 1, 1) : p.most_recent_completed_interview.interview_datetime }        
    elsif params[:sort] == PositionsHelper::ACTIVE_DESC
      @positions.sort_by { |p| p.active_interview.nil? ? DateTime.new(2300, 1, 1) : p.active_interview.interview_datetime }.reverse
    else
      @positions.sort_by { |p| p.active_interview.nil? ? DateTime.new(2300, 1, 1) : p.active_interview.interview_datetime }
    end    
  end
  
  def show
  end
  
  def new
    @leaders = Leader.all
    @users = User.all
    @position = Position.new
  end
  
  def edit
    @leaders = Leader.all
    @users = User.all
  end
  
  def create
    @position = Position.new(position_params)
    
    if @position.save
      redirect_to @position, notice: 'Position was successfully created.'
    else
      @leaders = Leader.all
      @users = User.all
      
      render action: 'new'
    end
  end
  
  def update
    if @position.update(position_params)
      redirect_to @position, notice: 'Position was successfully updated.'
    else
      @leaders = Leader.all
      @users = User.all      
      
      render action: 'edit'
    end
  end
  
  private
    
    def set_position
      @position = Position.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params.require(:position).permit(:leader_id, :name, :user_id, :meeting_time)
    end
  
end
