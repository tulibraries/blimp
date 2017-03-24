// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function () {
//  $('#upload_datafile').fileupload({
  $('#upload_fileupload').fileupload({
    dataType: 'script',
    done: function (e, data) {
      $.each(data.result.files, function (index, file) {
        $('<p/>').text(file.name).appendTo(document.body);
      });
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('#progress .bar').css(
                              'width',
                              progress + '%'
                              );
    }
  });

});
