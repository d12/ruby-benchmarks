tests = File.read("tests_to_run.txt").lines.map(&:chomp)
results_dir = "results"

tests.each do |test|
  test_name = test.split(".")[0]
  test_results_dir = "#{results_dir}/#{test_name}"
  if File.exists?(test_results_dir)
    puts "ERROR: Dir for test #{test_name} already exists. Please move or rename and try again."
    exit 1
  end

  Dir.mkdir(test_results_dir)

  puts "Starting test #{test_name}"
  
  5.times do |i|
    puts "  Iteration #{i}..."
    system("../all-ruby -e \"`cat #{test}`\" > #{test_results_dir}/#{i}")
  end
  
  puts "  Done!" 
end
