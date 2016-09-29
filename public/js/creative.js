// console.log("creative.js loaded");
function printMessage(message) {
  $('#messages').append(message + "<br>");
   // $("#messages").animate({
   //      scrollTop: $("#messages").height()
   //  }, 300);

   $("#messages").scrollTop = $("#messages").scrollHeight;
}

$(function() {
    // define variables for the channel and username
    var chatChannel;
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
            // make ajax call to send msg user entered back to server. backend setup route post messages when user clicks send msg make ajax request to send content back to route and route create message and save to db then send back response. Use.done append msg. only make sure db saves msg then send to other clients
            chatChannel.sendMessage($input.val())

            $input.val('');
        }
     });

    $.post("/tokens", function(data) {
      username = data.username;
      var accessManager = new Twilio.AccessManager(data.token);

      console.log("access manager:" + accessManager);

      var messagingClient = new Twilio.IPMessaging.Client(accessManager);

      // do it 5 times. create 5 diff channel and save
      // healht.js chatHealth
      // fitness.js chatFitness
      // put in diff chat name
      messagingClient.getChannelByUniqueName('creative').then(function(channel) {
          if (channel) {
              chatChannel = channel;
              setupChannel();
          } else {
              messagingClient.createChannel({
                  uniqueName: 'creative',
                  friendlyName: 'Creative' })
              .then(function(channel) {
                  chatChannel = channel;
                  setupChannel();
              });

          }
      });
  });

});
