require "benchmark"

small_array = [0] * 100_000
medium_array = [0] * 1_000_000
big_array = [0] * 10_000_000

Benchmark.bmbm do |x|
  x.report("small array") do
    500_000.times do |i|
      small_array.shift
      small_array.push i
    end
  end

  x.report("medium array") do
    500_000.times do |i|
      medium_array.shift
      medium_array.push i
    end
  end

  x.report("big array") do
    500_000.times do |i|
      big_array.shift
      big_array.push i
    end
  end
end