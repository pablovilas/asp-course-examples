#!/usr/bin/env ruby
require 'bunny'
require 'json'

abort "Usage: #{$PROGRAM_NAME} [action] [data]. Example: ruby #{$PROGRAM_NAME} create { \"id\": 1, \"name\": \"John\"}" if ARGV.empty?

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
exchange = channel.direct('users')
action = ARGV.shift || 'create'
message = ARGV.empty? ? {}.to_json : ARGV.shift.to_json

exchange.publish(message, routing_key: action)
puts " [x] Sent '#{message}'"

connection.close