module ReportsHelper
  
  def interviews_for_month(interviews, position, month_number)
    interviews[ReportsHelper.key(position, month_number)]
  end
  
  def self.key(position, month)
    "#{position.id}-#{month}"
  end

  def interview_days(interviews, position, month_number)
    interviews_for_month = interviews_for_month(interviews, position, month_number)
    if interviews_for_month.present?
      interviews_for_month.map { |interview| link_to(interview.interview_datetime.day, interview) }.join(', ')
    else
      ""
    end
  end
  
end
