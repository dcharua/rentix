var init_pago_lookup;

init_pago_lookup = function() {
  $('#pago-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#pago-lookup-form').on('ajax:after', function(event, data, status){
    hide_spinner();
  });

  $('#pago-lookup-form').on('ajax:success', function(event, data, status){
    $('#pago-lookup').replaceWith(data);
    init_pago_lookup();
  });

  $('#pago-lookup-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    $('#pago-lookup-results').replaceWith(' ');
    $('#pago-lookup-errors').replaceWith('La renta expíra antes de ese mes.');
  });
}



$(document).ready(function() {
  init_pago_lookup();
});
