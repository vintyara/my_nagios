$ ->
  $('img.spinner').hide()

  $('.check_now').click (event) ->
    onclick_check_now(event)



onclick_check_now = (event) ->
  $(event.target).closest('tr').addClass('updating')
  $(event.target).closest('tr').find('img.spinner').show()