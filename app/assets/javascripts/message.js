$(function(){
  function buildHTML(message){
    if(message.image != null){
       var image  = `<img src ="${message.image}" >`;
     }else{
       var image = '';
     }
    var html =`<div class= "main-body__text">
                  <div class = "main-body__name">
                    ${message.name}
                  </div>
                  <div class = "main-body__time">
                    ${message.time}
                  </div>
                  <div class = "main-body__message">
                    ${message.content}
                  </div>
                  <div class = "lower-message__content">
                    ${image}
                   </div>
                </div>
                `
    return html;
  }

  function scroll(){
    $('.main-body').animate({scrollTop: $('.main-body')[0].scrollHeight},'fast');
  };

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.main-body').append(html);
      $('.form__submit').prop("disabled", false);
      $('#new_message')[0].reset();
      scroll();
    })
    .fail(function(){
      alert('error');
    })
  })
})
