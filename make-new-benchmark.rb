require "fileutils"

def usage
  puts "Usage: ruby make-new-benchmark.rb benchmark_name"
end

unless name = ARGV[0]
  puts "ERROR: No benchmark name provided."
  usage
  exit 1
end

if name == "-v" || name == "--version"
  usage
  exit 0
end

begin
  Dir.mkdir(name)
rescue Errno::ENOENT
  puts "ERROR: Could not create benchmark directory."
end

FileUtils.cp(".templates/script.rb", "#{name}/#{name}.rb")
FileUtils.cp(".templates/README.md", "#{name}/README.md")