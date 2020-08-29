#!/usr/bin/env ruby
require 'bunny'

abort "Usage: #{$PROGRAM_NAME} [binding key] [message]. Example: ruby #{$PROGRAM_NAME} serviceA.info Service started" if ARGV.empty?

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
exchange = channel.topic('logs')
severity = ARGV.shift || 'anonymous.info'
message = ARGV.empty? ? '' : ARGV.shift

exchange.publish(message, routing_key: severity)
puts " [x] Sent #{severity}:#{message}"

connection.close