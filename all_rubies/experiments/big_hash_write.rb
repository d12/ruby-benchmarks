# Write system time to file
# Then read the file
#
def system_milis
  system("date +%s%3N > all_rubies_tmp_time")
  tmp_time_file = open("all_rubies_tmp_time", "r")
  tmp_time_file.gets.to_i
end

# TEST: Big hash, writing

a = system_milis()

hash = {}
i = 500000
while i > 0
  i -= 1
  hash[i] = i
end

b = system_milis()

print(b - a)
