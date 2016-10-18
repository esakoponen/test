require "benchmark"

def calc_with_explicit_block_passing(a, b, operation)
	operation.call(a, b)
end

def calc_with_implicit_block_passing(a, b)
	yield(a, b)
end

Benchmark.bmbm(10) do |report|
	report.report("explicit") do
		addition = lambda { |a, b| a + b }
		1000.times {calc_with_explicit_block_passing(5, 5, addition)}
	end
	report.report("implicit") do
		1000.times { calc_with_implicit_block_passing(5, 5) {|a, b| a + b }}
	end
end
