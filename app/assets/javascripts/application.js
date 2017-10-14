// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery/jquery-3.1.1.min.js
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require peity/jquery.peity.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require inspinia.js
//= require_tree
//= require steps/jquery.steps.min.js
//= require datapicker/bootstrap-datepicker.js
//= require iCheck/icheck.min.js
//= require steps/jquery.steps.min.js
//= require validate/jquery.validate.min.js
//= require dropzone/dropzone.js
//= require summernote/summernote.min.js
//= require colorpicker/bootstrap-colorpicker.min.js
//= require cropper/cropper.min.js
//= require datapicker/bootstrap-datepicker.js
//= require ionRangeSlider/ion.rangeSlider.min.js
//= require jasny/jasny-bootstrap.min.js
//= require jsKnob/jquery.knob.js
//= require nouslider/jquery.nouislider.min.js
//= require switchery/switchery.js
//= require chosen/chosen.jquery.js
//= require fullcalendar/moment.min.js
//= require clockpicker/clockpicker.js
//= require daterangepicker/daterangepicker.js
//= require select2/select2.full.min.js
//= require touchspin/jquery.bootstrap-touchspin.min.js
//= require bootstrap-markdown/bootstrap-markdown.js
//= require bootstrap-markdown/markdown.js
//= require bootstrap-tagsinput/bootstrap-tagsinput.js
//= require dualListbox/jquery.bootstrap-duallistbox.js
//= require typehead/bootstrap3-typeahead.min.js
//= require codemirror/codemirror.js
//= require codemirror/mode/javascript/javascript.js
//= require cocoon
//= require flot/jquery.flot.js
//= require flot/jquery.flot.tooltip.min.js
//= require flot/jquery.flot.resize.js
//= require flot/jquery.flot.pie.js
//= require flot/jquery.flot.time.js
//= require flot/jquery.flot.spline.js
//= require sparkline/jquery.sparkline.min.js
//= require chartjs/Chart.min.js
//= require jvectormap/jquery-jvectormap-2.0.2.min.js
//= require jvectormap/jquery-jvectormap-world-mill-en.js
//= require toastr/toastr.min.js
//= require sweetalert/sweetalert.min.js


var hide_spinner = function(){
  $('#spinner').hide();
}

var show_spinner = function(){
  $('#spinner').show();
}

$(function() {
    $('.datepicker').datepicker({format: 'yyyy-mm-dd'});
    $('.demo3').click(function () {
               swal({
                   title: "Are you sure?",
                   text: "You will not be able to recover this imaginary file!",
                   type: "warning",
                   showCancelButton: true,
                   confirmButtonColor: "#DD6B55",
                   confirmButtonText: "Yes, delete it!",
                   closeOnConfirm: false
               }, function () {
                   swal("Deleted!", "Your imaginary file has been deleted.", "success");
               });
           });

});


$(function() {
  $(".rentas_inquilino a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $('.rentas_inquilino').bind('cocoon:after-insert',
     function() {
       $(".rentas_inquilino_id").hide();
       $(".inquilino a.add_fields").hide();
     });
  $('.rentas_inquilino').bind("cocoon:after-remove",
     function() {
       $(".rentas_inquilino_id").show();
       $(".inquilino a.add_fields").show();
     });
});
