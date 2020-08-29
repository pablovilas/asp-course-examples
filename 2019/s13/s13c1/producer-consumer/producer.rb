#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('asp-queue')

message = 'Hello from ASP!'
channel.default_exchange.publish(message, routing_key: queue.name)
puts " [x] Sent #{queue.name} - #{message}"

connection.close