#!/usr/bin/env ruby

require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout('asp-pub-sub') # The Fanout exchange type routes messages to all bound queues indiscriminately

message = 'Hello from ASP!'

exchange.publish(message)
puts " [x] Sent #{message}"

connection.close