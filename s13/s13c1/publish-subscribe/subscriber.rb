#!/usr/bin/env ruby

require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout('asp-pub-sub')
queue = channel.queue('', exclusive: true) # Anon queue

queue.bind(exchange)

puts ' [*] Waiting for logs. To exit press CTRL+C'

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts " [x] Received #{queue.name} - #{body}"
  end
rescue Interrupt => _
  channel.close
  connection.close
end