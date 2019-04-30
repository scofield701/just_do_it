if(/chat/.test(window.location.pathname)) {
  var path = window.location.pathname.split('/');
  var room_id = path[path.length - 1];
  App.chat_room = App.cable.subscriptions.create({ channel: "ChatRoomChannel", room_id: room_id }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      // console.log(data['send_id']);
      // console.log(data['user_id']);
      // console.log(data['content']);
      // console.log(data['content2']);

      // if (data['send_id'] === data['user_id']) {
      //   $('.messages').append(data['content']);
      //   console.log('ok');
      // } else {
      //   $('.messages').append(data['content2']);
      //   console.log('no');
      // }
      $('.messages').append(data['content2']);

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
