$(document).ready(function(){
  var $temp = $('.temp_information').data('temp').hourly.data
  var tempArray = ['temperature']
  var timeArray = ['time']

  $temp.forEach(function(day) {
    tempArray.push(day.temperature);
    var date = new Date(day.time*1000);
    timeArray.push(date);
    console.log(date)
  });
  var chart = c3.generate({
    data: {
        x: 'time',
        xFormat: '%Y',
        columns: [
    //            ['x', '2012-12-31', '2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04', '2013-01-05'],
            timeArray,
            tempArray,
        ]
    },
    axis: {
        x: {
            label: "Time",
            type: 'timeseries',
            // if true, treat x value as localtime (Default)
            // if false, convert to UTC internally
            localtime: false,
            tick: {
                format: '%I:%M %p'
            }
        },
        y: {
          label: "Temperature (F)"
        }
    }
  });
})
