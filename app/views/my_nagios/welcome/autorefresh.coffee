$('#failures_list').replaceWith('<%= j render(partial: '/my_nagios/welcome/failures_list', locals: { criticals: @criticals, show_group: true }) %>')