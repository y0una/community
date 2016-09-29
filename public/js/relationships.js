$(document).ready(function() {
// top-right
  loginListener();
  registerListener();
});

var loginListener = function (){
  $('.top-bar-login').on('click', function(e){
    e.preventDefault();
    // toggle display element in CSS for login
    // if exists on pg then hide. If hidden then show
    $("#formContainer").toggle();


    var request = $.ajax({
      url: '/sessions/new',
      type: 'get'
    })

    request.done(function(response){
      // clears out form if there is 1 already
      $("#formContainer").empty().append(response);
    })
  })
}

var registerListener = function (){
  $('.top-bar-register').on('click', function(e){
    e.preventDefault();
    // toggle display element in CSS for login
    // if exists on pg then hide. If hidden then show
    $("#formContainer").toggle();


    var request = $.ajax({
      url: '/users/new',
      type: 'get'
    })

    request.done(function(response){
      // clears out form if there is 1 already
      // $("#formContainer").empty().append(response);
      $("#formContainer").empty().append(response);
    })
  })
}




function printMessage(message) {
  $('#messages').append(message + "<br>");
}

$(function() {
    // Manages state of access token we got from server
    var accessManager;

    // Interface to IP messaging service
    var messagingClient;

    // Handle to chatChannel
    var chatChannel;

    // Server assigns client random username - store value here
    var username;

    function setupChannel() {
        // join the channel and then print a message saying that the use has joined the channel
        chatChannel.join().then(function(channel) {
            printMessage(username + ' joined the chat.');
        });

        // bind an action to the messageAdded event (which comes from the Twilio SDK) to print the message to the screen
        chatChannel.on('messageAdded', function(message) {
            printMessage(message.author + ": " + message.body);
         });

    }

    var $input = $('#chat-input');
    $input.on('keydown', function(e) {
        if (e.keyCode == 13) {
            console.log($input.val());
            chatChannel.sendMessage($input.val())
            $input.val('');
        }
     });

    $.post("/tokens", function(data) {
      data = JSON.parse(data);

      console.log("data:" + data);
      console.log("data token:" + data["token"]);
      username = data["username"];
      console.log("username:" + username);
      var accessManager = new Twilio.AccessManager(data.token);
      console.log(accessManager);
      var messagingClient = new Twilio.IPMessaging.Client(accessManager);

      // do it 5 times. create 5 diff channel and save
      // healht.js chatHealth
      // fitness.js chatFitness
      // put in diff chat name
      messagingClient.getChannelByUniqueName('relationships').then(function(channel) {
          if (channel) {
              chatChannel = channel;
              setupChannel();
          } else {
              messagingClient.createChannel({
                  uniqueName: 'relationships',
                  friendlyName: 'Relationships' })
              .then(function(channel) {
                  chatChannel = channel;
                  setupChannel();
              });

          }
      });
  });

});
