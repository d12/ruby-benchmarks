require "benchmark"
ITERATIONS = 500_000
nums = Array.new(ITERATIONS) { rand(2**32) }

Benchmark.bmbm do |x|
  x.report("String count") do
    ITERATIONS.times do |i|
      nums[i].to_s(2).count("1")
    end
  end

  x.report("Bitmasks") do
    ITERATIONS.times do |i|
      num = nums[i]
      32.times.count do |i|
        num & (2**i) != 0
      end
    end
  end

  x.report("SWAR bithack") do
    m1 = 0x55555555
    m2 = 0x33333333
    m4 = 0x0f0f0f0f

    ITERATIONS.times do |i|
      num = nums[i]
      num -= (num >> 1) & m1
      num = (num & m2) + ((num >> 2) & m2)
      num = (num + (num >> 4)) & m4
      num += num >> 8
      (num + (num >> 16)) & 0x3f
    end
  end
end