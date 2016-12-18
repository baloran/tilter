$ ->
  $(".toggle-follow--link--js[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    console.log data
