class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # chatroom毎にidを分ける
    stream_for "chat_room_#{params[:room_id]}"
  end

  def unsubscribed
  end

  def speak(data)
    message = Message.create(room_id: data['room_id'], user_id: data['user_id'], message: data['message'])
    ChatRoomChannel.broadcast_to "chat_room_#{data['room_id']}", content: render_message_send(message), content2: render_message_received(message), send_id: data['user_id']
  end

  private

  def render_message_send(message)
    ApplicationController.renderer.render(partial: 'messages/message-send', locals: { message: message })
  end

  def render_message_received(message)
    ApplicationController.renderer.render(partial: 'messages/message-received', locals: { message: message })
  end
end
