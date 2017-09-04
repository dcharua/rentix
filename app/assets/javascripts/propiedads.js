var init_propiedad_lookup;

init_propiedad_lookup = function() {
  $('#propiedad-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#propiedad-lookup-form').on('ajax:after', function(event, data, status){
    hide_spinner();
  });

  $('#propiedad-lookup-form').on('ajax:success', function(event, data, status){
    $('#propiedad-lookup').replaceWith(data);
    init_propiedad_lookup();
  });

  $('#propiedad-lookup-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    $('#propiedad-lookup-results').replaceWith(' ');
    $('#propiedad-lookup-errors').replaceWith('No se encontraron propiedads.');
  });
}



$(document).ready(function() {
  init_propiedad_lookup();
});
