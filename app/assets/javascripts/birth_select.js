$( document ).on('turbolinks:load', function() {

  function monthday(year,month){
      var lastday = new Array('', 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
          lastday[2] = 29;
      }
      return lastday[month];
  }

  function setDay(){
      var year    = $('#user_birth_year').val();
      var month   = $('#user_birth_month').val();
      var day     = $('#user_birth_day').val();
      var lastday = monthday(year, month);
      var option = '';
      for (var i = 1; i <= lastday; i++) {
          if (i == day){
              option += '<option value="' + zeroPadding(i,2) + '" selected="selected">' + zeroPadding(i,2) + '</option>\n';
          }else{
              option += '<option value="' + zeroPadding(i,2) + '">' + zeroPadding(i,2) + '</option>\n';
          }
      }
      $('#user_birth_day').html(option);
  }

  setDate(1950);
  function setDate(startyear, endyear){
    var date = new Date();
    var nowyear = date.getFullYear();
    var month = 1;
    var day = 1;
    var yearOptions = '';
    var monthOptions = '';
    var dayOptions = '';

    if(!startyear || startyear == ""){
        startyear = nowyear - 30;
    }
    if(!endyear || endyear == ""){
        endyear = nowyear;
    }

    if(startyear < endyear){
        return;
    }
    for (var i=startyear; i <= endyear; i++){
        if(i == nowyear){
            yearOptions += '<option value="' + i + '" selected="selected">' + i + '</option>';
        }else{
            yearOptions += '<option value="' + i +'">' + i + '</option>';
        }
    }
    for (i=1; i<=12; i++){
        if(month == i){
            monthOptions += '<option value="' + zeroPadding(i,2) + '" selected="selected">' + zeroPadding(i,2) + '</option>';
        }else{
            monthOptions += '<option value="' + zeroPadding(i,2) +'">' + zeroPadding(i,2) + '</option>';
        }
    }
    for (i=1; i<=31; i++){
        if(day == i){
            dayOptions += '<option value="' + zeroPadding(i,2) + '" selected="selected">' + zeroPadding(i,2) + '</option>';
        }else{
            dayOptions += '<option value="' + zeroPadding(i,2) +'">' + zeroPadding(i,2) + '</option>';
        }
    }
    $('#user_birth_year').html(yearOptions);
    $('#user_birth_month').html(monthOptions);
    $('#user_birth_day').html(dayOptions);
  }

  $('#user_birth_year').change(function(){
    console.log("change")
    setDay();
  });
  $('#user_birth_month').change(function(){
    setDay();
  });
});
