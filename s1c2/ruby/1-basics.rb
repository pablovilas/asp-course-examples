# =================
# Introduction to Ruby
# =================

puts 'Hello from ASP!'

# =================
# types
# =================

# String
'Software Architecture in Practice'
  
# Symbol
:name # kind of string, immutable. See: https://reactive.io/tips/2009/01/11/the-difference-between-ruby-symbols-and-strings
  
# Fixnum (integer)
42
  
# Float
3.14
  
# TrueClass
true
  
# FalseClass
false
  
# NilClass (yes, even nil is a class!)
nil

# =================
# variables and class types
# =================

x = 'a string'    # x.class => String

x = 1             # x.class => Fixnum

x = 2.3           # x.class => Float

x = true          # x.class => TrueClass

x = false         # x.class => FalseClass

x = nil           # x.class => NilClass

# =================
# single quoted vs double quoted strings
# =================

puts 'Hello from ASP! \n Today\'s date is #{Time.now}'

puts "Hello from ASP! \n Today\'s date is #{Time.now}" # string interpollation and escape sequences

# =================
# array
# =================
  
countries = ['uruguay', 'brazil', 'argentina']

# =================
# hash
# =================

person = { name: 'Charlie Sheen', location: 'NYC' }
  
# =================
# collection (array of hashes)
# =================

people = [
    { name: 'Charlie Sheen', location: 'NYC' },
    { name: 'Jon Cryer', location: 'NYC' },
    { name: 'Angus T. Jones', location: 'Austin' }
]
  
# =================
# methods
# =================
  
# a simple method
#
def hello
    puts 'Hello from ASP!'
end

# with an argument
#
def hello(place)
    puts "Hello #{place}!"
end

# add a default to the argument
#
def hello(place = 'world')
    puts "Hello #{place}!"
end

# add a default to the argument
#
def hello(place = 'world', *args)
    #...
end
  
# =================
# blocks
# =================
  
3.times do
    puts 'Hello from ASP!'
end

# lets iterate over an array
#
countries.each do |country|
    puts "Hello #{country}"
end

# lets iterate over the hash
#
person.each do |key, value|
    puts "The value of #{key} is #{value}"
end

# this is also a block...
#
countries.each { |country| puts country.capitalize }

# =================
# ranges
# =================

cold_war = 1945..1989

alphabet = 'a'..'z'

cold_war.include?(1980) # => true

alphabet.each { |l| print l } # => abcdefghijklmnopqrstuvwxyz
