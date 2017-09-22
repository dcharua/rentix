var init_gasto_lookup;

init_gasto_lookup = function() {
  $('#gasto-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#gasto-lookup-form').on('ajax:after', function(event, data, status){
    hide_spinner();
  });

  $('#gasto-lookup-form').on('ajax:success', function(event, data, status){
    $('#gasto-lookup').replaceWith(data);
    init_gasto_lookup();
  });

  $('#gasto-lookup-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    $('#gasto-lookup-results').replaceWith(' ');
    $('#gasto-lookup-errors').replaceWith('La renta expíra antes de ese mes.');
  });
}



$(document).ready(function() {
  init_gasto_lookup();
});
