class ServerAuth
  def incoming(message, callback)
    unless message['channel'].match?(%r{^/meta})
      token = message.dig('ext', 'authToken')
      message['error'] = '403::Password required' unless token == FAYE_TOKEN
    end

    callback.call(message)
  end

  def outgoing(message, callback)
    message['ext']&.delete('authToken')
    callback.call(message)
  end
end
