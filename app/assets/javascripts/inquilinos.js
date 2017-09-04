var init_inquilino_lookup;

init_inquilino_lookup = function() {
  $('#inquilino-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#inquilino-lookup-form').on('ajax:after', function(event, data, status){
    hide_spinner();
  });

  $('#inquilino-lookup-form').on('ajax:success', function(event, data, status){
    $('#inquilino-lookup').replaceWith(data);
    init_inquilino_lookup();
  });

  $('#inquilino-lookup-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    $('#inquilino-lookup-results').replaceWith(' ');
    $('#inquilino-lookup-errors').replaceWith('No se encontraron inquilinos.');
  });
}



$(document).ready(function() {
  init_inquilino_lookup();
});
