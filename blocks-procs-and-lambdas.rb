# Blocks
#   Blocks are very handy and syntactically simple. However
#   we may want to have many different blocks at our disposal
#   and use them many times. As such, passing the same block
#   again and again would require us to repeat ourself.
#   However, as ruby is fully OO, this can be handled quite
#   cleanly by saving reusable code as an object itself.
#   This reusable code is called a Proc (Procedure).
#   The only difference between blocks and Procs is that a block
#   is a proc that cannot be saved, ans as such, is a one time
#   solution.
#
# Procs
#
# Lambdas
#
class Array
	def iterate_with_block_example!
		self.each_with_index do |n, i|
			self[i] = yield(n)
		end
	end
	# Passing an ampersand argument (a block)
	def iterate_with_proc_example!(&code)
		self.each_with_index do |n, i|
			self[i] = code.call(n)
		end
	end
	# Block is just a proc(edure)
	def what_i_am(&block)
		block.class
	end
end

array = [1, 2, 3, 4]
array.iterate_with_block_example! do |n|
	n ** 2
end
puts array.inspect
puts what_i_am {}
# => Proc

# Test with Procs
array1 = [1, 2, 3, 4]
array2 = [2, 4, 6, 8]
# Create a new procedure called 'square'
square = Proc.new do |n|
	n ** 2
end
array1.iterate_with_proc_example!(square)
array2.iterate_with_proc_example!(square)
array.iterate_with_proc_example!(Proc.new do |n| n ** 2 end)
puts array.inspect
