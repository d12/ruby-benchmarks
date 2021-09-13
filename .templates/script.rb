require "benchmark"

# Setup here

Benchmark.bmbm do |bm|
  bm.report("Something") do

  end

  bm.report("Something Else") do

  end
end