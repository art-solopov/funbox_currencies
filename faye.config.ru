# frozen_string_literal: true

require 'faye'
require_relative './faye/server_auth'
require_relative './config/initializers/faye_token'

bayeux = Faye::RackAdapter.new(mount: '/faye', timeout: 25)
bayeux.add_extension(ServerAuth.new)

bayeux.on(:handshake) do |client_id|
  puts "Handshake: #{client_id}"
end

bayeux.on(:subscribe) do |client_id, channel|
  puts "Subscribe: #{client_id} => #{channel}"
end

bayeux.on(:publish) do |client_id, channel, data|
  puts "Message from #{client_id} to #{channel} [#{data}]"
end

run bayeux
