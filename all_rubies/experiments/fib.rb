# Write system time to file
# Then read the file
#
def system_milis
  system("date +%s%3N > all_rubies_tmp_time")
  tmp_time_file = open("all_rubies_tmp_time", "r")
  tmp_time_file.gets.to_i
end

# TEST: Inefficient Fibonacci, method invocation and recursion

def fib(n)
  if n <= 2
    n
  else
    fib(n-1) + fib(n-2)
  end
end

a = system_milis()

fib(30)

b = system_milis()

print(b - a)
