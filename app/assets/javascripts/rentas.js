var init_rentas_lookup;

init_rentas_lookup = function() {
  $('#rentas-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#rentas-lookup-form').on('ajax:after', function(event, data, status){
    hide_spinner();
  });

  $('#rentas-lookup-form').on('ajax:success', function(event, data, status){
    $('#rentas-lookup').replaceWith(data);
    init_rentas_lookup();
  });

  $('#rentas-lookup-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    $('#rentas-lookup-results').replaceWith(' ');
    $('#rentas-lookup-errors').replaceWith('No se encontraron rentass.');
  });
}



$(document).ready(function() {
  init_rentas_lookup();
});
