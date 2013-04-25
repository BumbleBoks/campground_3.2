module Corner::LogsHelper
  Date::DATE_FORMATS[:calendar_date] = lambda do |date|
    date.strftime("#{Date::DAYS_INTO_WEEK.key(date.days_to_week_start).to_s.capitalize}, \
    %B %e %Y");
  end
end
