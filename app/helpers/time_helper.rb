require 'date'

module TimeHelper
  def unix_hour_parser(unix)
    datetime = DateTime.strptime(unix,'%s')
    datetime.strftime("%I:%M%p")
  end

  def unix_weekday_parser(unix)
    datetime = DateTime.strptime(unix,'%s')
    datetime.strftime("%a")
  end

  # def date_to_unix(date)
  #   p "THIS IS DATE_TO_UNIX RETURN VALUE"
  #   date.to_time.to_i
  # end
end
