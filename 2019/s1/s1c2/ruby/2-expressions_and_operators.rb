# ====================================
# expressions and operators
# ====================================
# ruby's syntax is expression-oriented.
# control structures such as 'if' that
# would be called statements in other 
# languages are actually expressions in
# ruby.

# =================
# quick examples of 
# operators
# =================

1 + 2             # => 3: addition  
2 * 3             # => 6: multiplication
1 + 2 == 3        # => true: == tests equality
2 ** 1024         # => 2 to the power of 1024
'dog' + 'pound'   # => "dogpound"
'hi ' * 3         # => "hi hi hi "

# =================
# if
# =================

if 2 + 2 == 5
    puts 'Equals to 5'
elsif 2 + 2 == 6
    puts 'Not equals to 6'
else
    puts 'Not equals to 5 or 6'
end

# =================
# unless
# =================

unless '5'.respond_to?(:each)
    puts 'Does not respond to "each" method'
else
    puts 'Respond to "each" method'
end

# more commonly used like this...
#
puts 'Hello from ASP!' unless ['8S', '7S'][rand(2)] == '7S'


# or...
# puts report.path unless report.path.nil?

# =================
# case
# =================

case rand(20)
when 0..5
    puts 'In range 0..5'
when 6..10
    puts 'In range 6..10'
else
    puts 'In range 11..20'
end