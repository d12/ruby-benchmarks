# Write system time to file
# Then read the file
#
def system_milis
  system("date +%s%3N > all_rubies_tmp_time")
  tmp_time_file = open("all_rubies_tmp_time", "r")
  tmp_time_file.gets.to_i
end

# TEST: Simple while loop & decrement

a = system_milis()

i = 500000
while i > 0
  i -= 1
end

b = system_milis()

print(b - a)
