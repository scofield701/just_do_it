document.addEventListener("turbolinks:load", function() {
  App.chat_room.unsubscribe();
  if(/chat/.test(window.location.pathname)) {
    var path = window.location.pathname.split('/');
    var room_id = path[path.length - 1];
    App.chat_room = App.cable.subscriptions.create({ channel: "ChatRoomChannel", room_id: room_id }, {
      connected: function() {
        $("#messages").scrollTop($("#messages")[0].scrollHeight);
      },
      disconnected: function() {},
      received: function(data) {
        $('#messages').append(data['content']);
        $("#messages").scrollTop($("#messages")[0].scrollHeight);
      },
      speak: function(message) {
        return this.perform('speak', {
          message: message,
          room_id: room_id,
          user_id: $('meta[name="current_user_id"]').attr('content')
        });
      }
    });
    $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
      if (event.keyCode === 13) {
        App.chat_room.speak(event.target.value);
        event.target.value = '';
        return event.preventDefault();
      }
    });
  }
});
