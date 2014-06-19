module PositionsHelper

  COMPLETED_ASC = 'completed-interview-asc'
  COMPLETED_DESC = 'completed-interview-desc'
  ACTIVE_ASC = 'active-interview-asc'
  ACTIVE_DESC = 'active-interview-desc'
  
  def active_interview_text(interview)
    interview.interview_datetime.to_formatted_s(:short_and_easy_with_year)
  end

  def active_interview_sort_link
    if params[:sort].nil? || params[:sort] == ACTIVE_ASC
      link_to(image_tag("arrow-up.png"), positions_path(:sort => ACTIVE_DESC)).html_safe
    elsif params[:sort] == ACTIVE_DESC
      link_to(image_tag("arrow-down.png"), positions_path(:sort => ACTIVE_ASC)).html_safe
    else
      link_to(image_tag("up-and-down.png"), positions_path(:sort => ACTIVE_DESC)).html_safe
    end
  end
  
  def latest_completed_interview_sort_link
    if params[:sort] == COMPLETED_ASC
      link_to(image_tag("arrow-up.png"), positions_path(:sort => COMPLETED_DESC)).html_safe
    elsif params[:sort] == COMPLETED_DESC
      link_to(image_tag("arrow-down.png"), positions_path(:sort => COMPLETED_ASC)).html_safe
    else
      link_to(image_tag("up-and-down.png"), positions_path(:sort => COMPLETED_DESC)).html_safe
    end    
  end
  
end
