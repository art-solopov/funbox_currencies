class ExternalService::Faye
  class TokenExtension
    def outgoing(message, callback)
      message['ext'] = message.fetch('ext', {}).merge(authToken: FAYE_TOKEN)
      callback.call(message)
    end
  end

  def self.publish(queue, message)
    EM.run do
      client = Faye::Client.new(Rails.application.config.faye_server)
      client.add_extension(TokenExtension.new)
      pub = client.publish(
        queue,
        message
      )
      pub.callback do
        Rails.logger.info('Message sent successfully')
        EM.stop_event_loop
      end
      pub.errback do |error|
        Rails.logger.error("There was an error: #{error}")
        EM.stop_event_loop
      end
    end
  end
end
