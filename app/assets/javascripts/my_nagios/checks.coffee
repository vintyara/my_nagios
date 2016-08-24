$ ->
  $('img.spinner').hide()

  # Group Check Action
  $('#group_action').hide()
  $('#snooze_time_select').hide()

  $('#check_group_action').change (event) ->
    if $(this).val() == 'Snooze for' then $('#snooze_time_select').show() else $('#snooze_time_select').hide()

  $('.check_now').click (event) ->
    onclick_check_now(event)

  # Select all checkboxes in group
  $('.select_all_group').click (event) ->
    group_id = $(this).data('select-all-group')
    $(':checkbox.group_' + group_id).click()

  # Select all checkboxes
  $('#select_all').click (event) ->
    $(':checkbox.select_all_group').click()

  # Show and hide action dialog for selected checkboxes, store selected check ids
  $('.my_nagios_check :checkbox').change (event) ->
    if $('input:checked').length > 0
      $('#group_action').show();
      selected_ids = $('input:checked').map () ->
        return $(this).data('check-id')

      $('#group_action_check_ids').val(selected_ids.get() + '')
    else
      $('#group_action_check_ids').val('')
      $('#group_action').hide();


@onclick_check_now = (event) ->
  $(event.target).closest('tr').addClass('updating')
  $(event.target).closest('tr').find('img.spinner').show()