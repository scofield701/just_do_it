$( document ).on('turbolinks:load', function() {

  function monthday(year,month){
    var lastday = new Array('', 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
      lastday[2] = 29;
    }
    return lastday[month];
  }

  function setDay(select){
    var year    = $('#user_birth_year').val();
    var month   = $('#user_birth_month').val();
    var day     = $('#user_birth_day').val();
    var lastday = monthday(year, month);
    var option = '';
    if(lastday < select){
      day = 1;
    }
    for (var i = 1; i <= lastday; i++) {
      if (i == day){
        option += '<option value="' + i + '" selected="selected" id="day" >' + i + '</option>';
      }else{
        option += '<option value="' + i + '" id="day">' + i + '</option>';
      }
    }
    $('#user_birth_day').html(option);
    return lastday;
  }

  function setDate(){
    var today = new Date();
    var nowyear = today.getFullYear() - 16;
    var startyear = nowyear - 70;
    var nowmonth = 1;
    var day = 1;
    var days = monthday(nowyear, nowmonth);
    var monthOptions = '';
    var dayOptions = '';
    var yearOptions = '';

    for (i = startyear; i <= nowyear; i++){
      if(i == nowyear){
        yearOptions += '<option value="' + i + '" selected="selected" id="year">' + i + '</option>';
      } else {
        yearOptions += '<option value="' + i +'" id="year">' + i + '</option>';
      }
    }
    for (i = 1; i <= 12; i++){
      if(nowmonth == i){
        monthOptions += '<option value="' + i + '" selected="selected" id="month">' + i + '</option>';
      } else {
        monthOptions += '<option value="' + i +'" id="month">' + i + '</option>';
      }
    }
    for (i = 1; i <= days; i++){
      if(day == i){
        dayOptions += '<option value="' + i + '" selected="selected" id="day">' + i + '</option>';
      } else {
        dayOptions += '<option value="' + i +'" id="day">' + i + '</option>';
      }
    }
    $('#user_birth_year').html(yearOptions);
    $('#user_birth_month').html(monthOptions);
    $('#user_birth_day').html(dayOptions);
  }

  function setSelect(){
    $(".custom-select").each(function() {
      var classes = $(this).attr("class"),
        id      = $(this).attr("id");
        template = '';
      if(id == "user_birth_day"){
        template +=  '<div class="' + classes + '" id="' + id + '_select">';
        template += '<span class="custom-select-trigger" id="day-trigger">' + $(this).attr("placeholder") + '</span>';
        template += '<div class="custom-options day-options">';
      } else {
        template +=  '<div class="' + classes + '" id="' + id + '_select">';
        template += '<span class="custom-select-trigger">' + $(this).attr("placeholder") + '</span>';
        template += '<div class="custom-options">';
      }
      $(this).find("option").each(function() {
        var optionId = $(this).attr("id");
        if(optionId == "year"){
          template += '<span class="custom-option year" data-value="' + $(this).attr("value") + '">' + $(this).html() + '</span>';
        } else if(optionId == "month") {
          template += '<span class="custom-option month" data-value="' + $(this).attr("value") + '">' + $(this).html() + '</span>';
        } else {
          template += '<span class="custom-option day" id="day_span_' + $(this).attr("value") +'" data-value="' + $(this).attr("value") + '">' + $(this).html() + '</span>';
        }
      });
      template += '</div></div>';

      $(this).wrap('<div class="custom-select-wrapper"></div>');
      $(this).hide();
      $(this).after(template);
    });
  }

  function selectDay(lastday, select){
    var maxday = $('.none').html();
    if(maxday == null){
      maxday = $('.day:last-child').html();
    } else {
      maxday -= 1;
    }
    console.log(maxday);
    console.log(lastday);
    if(lastday < select){
      $(`#day_span_${select}`).removeClass("selection");
      $('#day_span_1').addClass("selection");
      $('#day-trigger').text("1");
    }
    if(maxday > lastday){
      for (i = lastday + 1; i <= maxday; i++){
        $(`#day_span_${i}`).addClass("none");
        console.log("add")
      }
    } else{
      for (i = maxday + 1; i <= lastday; i++){
        $(`#day_span_${i}`).removeClass("none");
        console.log("remove");
      }
    }
  }

  function clickSpan(click){
    $(click).parents(".custom-select-wrapper").find("select").val(click.data("value"));
    $(click).parents(".custom-options").find(".custom-option").removeClass("selection");
    $(click).addClass("selection");
    $(click).parents(".custom-select").removeClass("opened");
    $(click).parents(".custom-select").find(".custom-select-trigger").text(click.text());
  }

  setDate();
  setSelect();

  $(".custom-option:first-of-type").hover(function() {
    $(this).parents(".custom-options").addClass("option-hover");
  }, function() {
    $(this).parents(".custom-options").removeClass("option-hover");
  });

  $(".custom-select-trigger").on("click", function() {
    $('html').one('click',function() {
      $(".custom-select").removeClass("opened");
    });
    $(this).parents(".custom-select").toggleClass("opened");
    event.stopPropagation();
  });

  $('.year').on('click', function(){
    clickSpan($(this));
    var select = $('.selection' + '.day').html();
    var lastday = setDay(select);
    selectDay(lastday, select);
  });
  $('.month').on('click', function(){
    clickSpan($(this));
    var select = $('.selection' + '.day').html();
    var lastday = setDay(select);
    selectDay(lastday, select);
  });
  $('.day').on('click', function(){
    clickSpan($(this));
  });

});
