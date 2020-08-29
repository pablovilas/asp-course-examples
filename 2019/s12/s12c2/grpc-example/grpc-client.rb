this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'helloworld_services_pb'

def main
  stub = Helloworld::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure)
  name = ARGV.size > 0 ? ARGV[0] : 'world'
  lastName = ARGV.size > 1 ? ARGV[1] : ''
  message = stub.say_hello(Helloworld::HelloRequest.new(name: name, lastName: lastName)).message
  p "Greeting: #{message}"
end

main