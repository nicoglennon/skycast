
module IconHelper
  def lookup_icon(response)
    if ['clear-day', 'clear-night'].include?(response)
      "fa fa-sun-o"
    elsif ['rain', 'snow', 'sleet', 'wind', 'fog'].include?(response)
      "fa fa-umbrella"
    elsif ['cloudy', 'partly-cloudy-day', 'partly-cloudy-night'].include?(response)
      "fa fa-cloud"
    end
  end
end
