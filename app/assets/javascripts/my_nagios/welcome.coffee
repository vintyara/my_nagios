$ ->
  refresh_rate = 15000

  setInterval () ->
    $('table.failures_list').addClass('refresing')
    show_timer(refresh_rate)

    $.ajax
      url: '/autorefresh'
      type: "POST"
      dataType: "script"
  , refresh_rate

  show_timer = (counter) ->
    counter = (counter / 1000) % 60

    interval = setInterval () ->
      counter -= 1

      clearInterval(interval) if counter == 0

      $('#failures_list .timer').html(counter)
    , 1000

  $(document).ready(show_timer(refresh_rate))