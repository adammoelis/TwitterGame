// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets
$( document ).ready(function() {
    hideAddUsername()
    hideRemoveUsername()
    showAddUsername()
    showRemoveUsername()
    $('.social-pop-up').click(function(event) {
        var width  = 575,
            height = 400,
            left   = ($(window).width()  - width)  / 2,
            top    = ($(window).height() - height) / 2,
            url    = this.href,
            opts   = 'status=1' +
                     ',width='  + width  +
                     ',height=' + height +
                     ',top='    + top    +
                     ',left='   + left;

        window.open(url, 'twitter', opts);

        return false;
      });

});

function hideAddUsername() {
  $('input#username').hide();
  $('input#add-username-submit').hide();
}

function hideRemoveUsername() {
  $('select#user_name').hide();
  $('input#remove-username-submit').hide();
}

function showAddUsername() {
  $('label#add-username').click(function(){
    $('input#username').slideToggle();
    $('input#add-username-submit').slideToggle();
  })
}

function showRemoveUsername() {
  $('label#remove-username').click(function(){
    $('select#user_name').slideToggle();
    $('input#remove-username-submit').slideToggle();
  })
}
