#!/usr/bin/env ruby
require 'bunny'

abort "Usage: #{$PROGRAM_NAME} [create] [update] [delete]. Example: ruby #{$PROGRAM_NAME} create update" if ARGV.empty?

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
exchange = channel.direct('users')
queue = channel.queue('', exclusive: true)

ARGV.each do |action|
  queue.bind(exchange, routing_key: action)
end

puts ' [*] Waiting for users events. To exit press CTRL+C'

begin
  queue.subscribe(block: true) do |delivery_info, _properties, body|
    puts " [x] #{delivery_info.routing_key}: #{body}"
  end
rescue Interrupt => _
  channel.close
  connection.close
  exit(0)
end