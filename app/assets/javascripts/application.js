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
  displayTweet();
    hideAddUsername();
    hideRemoveUsername();
    showAddUsername();
    showRemoveUsername();
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
      preventButtonClicking();
      playGame();

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

function preventButtonClicking(){
  $('input.myButton').click(function(e){
    e.preventDefault()
  })
}

function rightAnswer() {
  return $('input.right-answer').val()
}

function selectedAnswer() {
  $('input.myButton').click(function(){
    return $(this).val();
  })
}

function getAccountArray (){
  return $('input:hidden#game_accounts').val().split("^@$#");
}

function getTweetArray (){
  return $('input:hidden#game_tweets').val().split("^@$#");
}

var round = 1;
var score = 0;
var attempts = 0;

function increaseRound(){
  round++
}

function increaseAttempts(){
  attempts++
}

function increaseScore(){
  score++
}

function displayTweet(){
  $('h2.tweet_text').text(getTweetArray()[round-1]);
}

function setScore(selected){
  if(selected == getAccountArray()[round-1]){
    increaseScore()
  }
  $('input[name=score]').val(score)
}

function setAttempts(){
  increaseAttempts()
  $('input[name=attempts]').val(attempts)
}

function displayRightAnswer(){
  $('input[name=attempts]').val(attempts)
}

function setPercentage(){
  if(attempts == 0){
    $('input[name=percentage]').val("N/A")
  }
  else {
    $('input[name=percentage]').val(Math.round(100*score/attempts)+"%")
  }

}

function setFeedback(){
  var percentage = 100*score/attempts;
  if(attempts == 0){
    $('input.feedback').val('None Wrong ... yet');
  }
  else{
      if(percentage >=75 && percentage <=100){
          $('input.feedback').val('Great Job!');
          $('input.feedback').addClass("great");
          $('input.feedback').removeClass("good");
          $('input.feedback').removeClass("bad");
          $('input.feedback').removeClass("terrible");
      }
      else if (percentage >=50 && percentage <75){
          $('input.feedback').val('Okay Job');
          $('input.feedback').addClass("good");
          $('input.feedback').removeClass("great");
          $('input.feedback').removeClass("bad");
          $('input.feedback').removeClass("terrible");
      }
      else if (percentage >=25 && percentage <50){
          $('input.feedback').val('You KINDA suck');
          $('input.feedback').addClass("bad");
          $('input.feedback').removeClass("great");
          $('input.feedback').removeClass("good");
          $('input.feedback').removeClass("terrible");
      }
      else if (percentage >=0 && percentage <25){
          $('input.feedback').val('You REALLY suck');
          $('input.feedback').addClass("terrible");
          $('input.feedback').removeClass("great");
          $('input.feedback').removeClass("good");
          $('input.feedback').removeClass("bad");
      }
    }
  }



function playGame (){
  $('input.myButton').click(function(){
    var selected = $(this).val();
    setScore(selected);
    setAttempts();
    setPercentage();
    setFeedback();
    displayRightAnswer();
    increaseRound();
    displayTweet();
  })
}
