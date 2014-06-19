class ReportsController < ApplicationController
  
  def text_report    
    setup_text_report_vars
    @report_generated = false
    
    render :report_one
  end
  
  def generate_text_report
    setup_text_report_vars
    
    janfeb_selected = params[:janfeb] == "true"
    marapr_selected = params[:marapr] == "true"
    mayjun_selected = params[:mayjun] == "true"
    julaug_selected = params[:julaug] == "true"
    sepoct_selected = params[:sepoct] == "true"
    novdec_selected = params[:novdec] == "true"
    
    months_to_consider = []
    months_to_consider += [1, 2] if janfeb_selected
    months_to_consider += [3, 4] if marapr_selected
    months_to_consider += [5, 6] if mayjun_selected
    months_to_consider += [7, 8] if julaug_selected
    months_to_consider += [9, 10] if sepoct_selected
    months_to_consider += [11, 12] if novdec_selected
    
    if months_to_consider.empty?
      
      flash.now.alert = "Please select some month combinations."
      
    else
      @report_generated = true      
      
      positions = @leader.positions
      number_of_positions = positions.count

      @number_of_interviews_leader_should_have_done = number_of_positions * ([janfeb_selected, marapr_selected, mayjun_selected, julaug_selected, sepoct_selected, novdec_selected].count { |x| x == true })

      start_date = Date.new(@year, 1, 1)
      end_date = Date.new(@year, 12, 31)

      @interviews = []

      positions.each do |position|
        interviews_for_the_year = position.interviews.where(:status_id => InterviewStatus::COMPLETED.id).where("interview_datetime >= ? and interview_datetime <= ?", start_date, end_date)
        @interviews += interviews_for_the_year.select { |i| months_to_consider.include?(i.interview_datetime.month) }
      end

      @number_of_completed_interviews = @interviews.count


      @positions_they_saw = @interviews.map { |i| i.position }.uniq
      @positions_they_did_not_see = positions - @positions_they_saw

      @percentage_completed = ((@number_of_completed_interviews.to_f / @number_of_interviews_leader_should_have_done) * 100).round(1)      
      
    end
    
    render :report_one
  end
  
  def table_report
    @leaders = Leader.all
    @years = (2014..DateTime.now.year).to_a
    
    @leader = if params[:leader_id]
      Leader.find(params[:leader_id])
    else
      @leaders.first
    end
    
    @year = if params[:year]
      params[:year].to_i
    else      
      @years.last
    end
    
    start_date = Date.new(@year, 1, 1)
    end_date = Date.new(@year, 12, 31)
    
    @interviews = {}
    @positions = @leader.positions
    @positions.each do |position|
      position.interviews.where(:status_id => InterviewStatus::COMPLETED.id).where("interview_datetime >= ? and interview_datetime <= ?", start_date, end_date).each do |interview|
        hash_key = ReportsHelper.key(position, interview.interview_datetime.month)
        @interviews[hash_key] ||= []
        @interviews[hash_key] << interview
      end
    end
    
    render :table_report
  end
  
  private
  
  def setup_text_report_vars
    @leaders = Leader.all
    @years = (2014..DateTime.now.year).to_a
    
    @leader = if params[:leader_id]
      Leader.find(params[:leader_id])
    else
      @leaders.first
    end
    
    @year = if params[:year]
      params[:year].to_i
    else      
      @years.last
    end    
  end
  
  
end
