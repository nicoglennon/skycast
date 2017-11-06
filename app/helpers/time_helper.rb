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
end
