#!/usr/bin/ruby

puts "hello"
puts("hi there")


value = "blah"

items=[1,2,3,4,5,6]

puts("the value is " + value)

for item in items
	puts(item)
end

items.each do | item |
	puts(item)
end

items.each { | item | puts(item) }

for i in 0.step(5)
	puts(items[i])
end

puts(items)
