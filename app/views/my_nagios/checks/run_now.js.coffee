tr = '<%= dom_id(@check) %>'
$('#' + tr).replaceWith('<%= j render(partial: '/my_nagios/checks/check_row', locals: { check: @check, run_now: true }) %>')

tr = '<%= dom_id(@check) %>'
$('#' + tr).find('img.spinner').hide()

$('#' + tr).find('a.check_now').click (event) ->
  onclick_check_now(event)

onclick_check_now = (event) ->
  $(event.target).closest('tr').addClass('updating')
  $(event.target).closest('tr').find('img.spinner').show()