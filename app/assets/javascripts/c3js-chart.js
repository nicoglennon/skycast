$(document).ready(function(){
  var $temp = $('.temp_information').data('temp').hourly.data
  var tempArray = ['temperature']
  var apparArray = ['felt like']
  var timeArray = ['time']

  // manually setting the time for each datapoint from midnight to midnight - the data being sent back is timezone dependent, so easier to set manually than to convert each time data point
  var hour = 0;
  $temp.forEach(function(day) {
    tempArray.push(day.temperature);
    apparArray.push(day.apparentTemperature);
    var date = new Date().setHours(hour, 0, 0);
    console.log(date);
    hour += 1;
    timeArray.push(date);
    console.log(date)
  });
  var chart = c3.generate({
    data: {
        x: 'time',
        xFormat: '%Y',
        columns: [
            timeArray,
            tempArray,
            apparArray
        ],
        types: {
                'temperature': 'area-spline',
                'felt like': 'area-spline',
        },
    },
    axis: {
        x: {
            label: "Time",
            type: 'timeseries',

            // if true, treat x value as localtime (Default)
            // if false, convert to UTC internally
            localtime: true,
            tick: {
                format: '%I:%M %p'
            }
        },
        y: {
          label: "Temperature (F)"
        }
    },
    zoom: {
        enabled: true
    }
  });
})
