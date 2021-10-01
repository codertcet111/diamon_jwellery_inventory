//= require_tree .

$(document).ready(function() {
  $(document.body).on('change', '#payment_payment_mode', function() {
    var selected = $('#payment_payment_mode option:selected').html();
    if (selected.toLowerCase().includes('angadia')) {
      $('#payment_party_come_field').fadeIn("slow");
      $('#payment_pc_acc_name_field').fadeIn("slow");
      $('#payment_party_paid_field').fadeIn("slow");
      $('#payment_pp_acc_name_field').fadeIn("slow");
    } else {
      $('#payment_party_come_field').fadeOut("slow");
      $('#payment_pc_acc_name_field').fadeOut("slow");
      $('#payment_party_paid_field').fadeOut("slow");
      $('#payment_pp_acc_name_field').fadeOut("slow");
    }
  });
  $(document.body).on('change', '#receipt_receipt_mode', function() {
    var selected = $('#receipt_receipt_mode option:selected').html();
    if (selected.toLowerCase().includes('angadia')) {
      $('#receipt_party_come_field').fadeIn("slow");
      $('#receipt_pc_acc_name_field').fadeIn("slow");
      $('#receipt_party_paid_field').fadeIn("slow");
      $('#receipt_pp_acc_name_field').fadeIn("slow");
    } else {
      $('#receipt_party_come_field').fadeOut("slow");
      $('#receipt_pc_acc_name_field').fadeOut("slow");
      $('#receipt_party_paid_field').fadeOut("slow");
      $('#receipt_pp_acc_name_field').fadeOut("slow");
    }
  });
});