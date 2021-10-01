require "byebug"
directories = Dir["*"]
directories.each do |test_name|
  next unless File.directory?(test_name)
  results = {}
  Dir["#{test_name}/*"].each do |test_file|
    next unless ["#{test_name}/0", "#{test_name}/1", "#{test_name}/2", "#{test_name}/3", "#{test_name}/4"].include?(test_file)
    data = File.read(test_file).lines.map(&:chomp).map{|a| a.split(" ")}
    data.each do |ruby_version, time|
      results[ruby_version] ||= []
      results[ruby_version] << time.to_i
    end
  end

  string_to_print = ""

  results.each do |ruby_version, results|
    byebug if ruby_version == "ruby-0.49"
    mean_result = results.sum(0.0) / results.length
    string_to_print += "#{ruby_version}\t#{mean_result.round(2)}\n"
  end

  File.write("#{test_name}/averages.csv", string_to_print)
end
