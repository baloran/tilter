$ ->
  $(".toggle-follow--link--js[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    console.log data

  $(".tilt__action a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    if $(this).parent().hasClass('tilt__action--active')
      $(this).parent().removeClass('tilt__action--active')
      span = $(this).parent().find('span')
      span.text(parseInt(span.text()) - 1)
      console.log 'have'
    else
      $(this).parent().addClass('tilt__action--active')
      span = $(this).parent().find('span')
      span.text(parseInt(span.text()) + 1)
      console.log 'not have'
    
    
