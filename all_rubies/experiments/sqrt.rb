# Write system time to file
# Then read the file
#
def system_milis
  system("date +%s%3N > all_rubies_tmp_time")
  tmp_time_file = open("all_rubies_tmp_time", "r")
  tmp_time_file.gets.to_i
end

# TEST: Sqrt test, Floating point arithmetic

a = system_milis()

i = 500000
while i > 0
  i -= 1

  (i * 1.333) ** 0
  (i * 2.333) ** 0
  (i * 3.333) ** 0
  (i * 4.333) ** 0
  (i * 5.333) ** 0
  (i * 6.333) ** 0
  (i * 7.333) ** 0
  (i * 8.333) ** 0
  (i * 9.333) ** 0
end

b = system_milis()

print(b - a)
