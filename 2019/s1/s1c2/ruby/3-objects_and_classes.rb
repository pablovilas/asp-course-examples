# ================================
# objects
#
# all values are objects, and
# there is no distinction between
# primitives types and object
# types. Every thing is an Object!
#
# ================================

# =================
# classes
# =================

class Foo
    #...
end

foo = Foo.new
  
# =================
# initialize
# =================
  
class Person
    attr_reader :name

    def initialize(name)
        @name = name
    end
end
  
person = Person.new('John')
person.name # => "John"
  
# =================
# getters and setters
# =================

class Person
    def age
        @age
    end

    def age=(age)
        @age = age
    end
end
  
# OR
  
class Person
    attr_accessor :age
end