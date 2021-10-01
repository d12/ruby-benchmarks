# Write system time to file
# Then read the file
#
def system_milis
  system("date +%s%3N > all_rubies_tmp_time")
  tmp_time_file = open("all_rubies_tmp_time", "r")
  tmp_time_file.gets.to_i
end

# TEST: Class initialization

class A
  def A.new(foo)
    @foo = foo
  end
end

a = system_milis()

i = 500000
while i > 0
  i -= 1
  foo = A.new(0)
  bar = A.new(1)
  buzz = A.new(2)
  bazz = A.new(3)
end

b = system_milis()

print(b - a)
