class ExternalService::Publish
  def self.publish(queue, event, message)
    Pusher.trigger(queue, event, message)
  end
end
