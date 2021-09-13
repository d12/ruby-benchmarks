require "benchmark"

def one_arg_recursion(a, i)
  print "\r  Depth: #{i}"
  one_arg_recursion(a, i + 1)
end

def one_arg_recursion_no_tailcall(a, i)
  print "\r  Depth: #{i}"
  one_arg_recursion(a, i + 1)

  0
end

def five_arg_recursion(a, b, c, d, e, depth)
  print "\r  Depth: #{depth}"
  five_arg_recursion(a, b, c, d, e, depth + 1)
end

class DummyClass
end

NEWLINES = "\n" * 2

# Begin experiments

puts "Recursing with one string arg:"
begin
  one_arg_recursion("first arg", 0)
rescue SystemStackError
end

puts NEWLINES
puts "Recursing with one int arg:"

begin
  one_arg_recursion(0, 0)
rescue SystemStackError
end

puts NEWLINES
puts "Recursing with one int arg and no tailcall:"
begin
  one_arg_recursion_no_tailcall(DummyClass.new, 0)
rescue SystemStackError
end

puts NEWLINES
puts "Recursing with one class arg:"
begin
  one_arg_recursion(DummyClass.new, 0)
rescue SystemStackError
end

puts NEWLINES
puts "Recursing with 5 string args"
begin
  five_arg_recursion("first arg", "second arg", "third arg", "fourth arg", "fifth arg", 0)
rescue SystemStackError
end

puts NEWLINES
puts "Recursing with 5 longer string args"
begin
  five_arg_recursion("first arg" * 10, "second arg" * 10, "third arg" * 10, "fourth arg" * 10, "fifth arg" * 10, 0)
rescue SystemStackError
end