# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(function($){

  $('.button-flag').on('click', function(e){
    if( $('body').hasClass('index-out') == true ){
      removeIndexOut();
    } else {
      addIndexOut();
    }
  });

  $('.button-find').on('click', function(e){
    if( $('body').hasClass('index-out') == true ){
      removeIndexOut();
    } else {
      addIndexOut();
    }
  });

  var removeIndexOut = function(){
    $('body').removeClass('index-out');
  }
  var addIndexOut = function(){
    $('body').addClass('index-out');
  }

})(jQuery);
