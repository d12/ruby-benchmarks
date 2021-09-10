require "benchmark"

values = [100, 200, 400, 800, 1600, 3200, 6400, 12800, 25600]
arrays = values.map { |value| [Array.new(value) { rand(value) }, Array.new(value) { rand(value) }] }

Benchmark.bmbm do |x|
  values.each_with_index do |n, index|
    x.report("Array#&(#{n})") do
      5_000.times do
        arrays[index][0] & arrays[index][1]
      end
    end
  end
end