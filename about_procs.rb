def callbacks(procs)
    procs[:starting].call
    puts "Still going"
    procs[:finishing].call
end
callbacks(:starting => Proc.new { puts "Starting"},
          :finishing => Proc.new { puts "Finishing" })
# When to use blocks over Procs? This is just an example:
# 1. Block: your method is breaking an object down into smaller pieces,
#    and you want to let your users interact with these pieces
# 2. Block: you want to run multiple expressions atomically, like
#    database migration.
# 3. Proc: you want to use a block of code multiple times
# 4. Proc: your method will have one or more callbacks

# About lambdas too
# So far, you have used Procs in two ways, passing the directly as a an attribute
# and saving them as a variable. These Procs act very similar to what other
# languages call anonymous functions, or lambdas.
class Array
    def iterate!(code)
        self.each_with_index do |n, i|
            self[i] = code.call(n)
        end
    end
end
array = [1,2,3,4]
array.iterate!(lambda { |n| n**2 })
# On first look, lambdas seem to be exactly the same as Procs.
# However, there are two subtle differences. The first difference
# is that, unlike Procs, lambdas check the number of arguments passed.
def args(code)
    one, two = 1, 2
    code.call(one, two)
end
args(Proc.new{|a, b, c| puts "Give me a #{a}, and a #{b} and a #{c.class}"})
args(lambda{|a, b, c| puts "Give me a #{a}, and a #{b} and a #{c.class}"})
# We see with the Proc example that extra variables are set to nil.
# However with lambdas, Ruby throws an error instead.

# The second difference is that lambdas have diminutive returns.
# What this means is that while a PRoc return wil stop a method
# and retuen the value provided, lambdas will return their value
# to the method and let the method continue on.

# In proc_return, out method hits a return keyword, stops processing
# the rest of the method and returns the string "Proc.new". On the
# other hand, our lambda_return method hits our lambda, keeps going
# and hits the next return and outputs "lambda_return...".
# Why the difference?
#
# The answer is in the conceptual difference between procedures and methods.
# Procs in Ruby are drop in code snippets, not methods. Because of this,
# the Proc return is the proc_return method's return, and act accordingly.
# Lambdas however act just lie methods, as they check the number of arguments
# and do not override the calling methods return. For this reason, it is best
# to think of lambdas as another way to write methods, an anonymous way of that.
def generic_return(code)
    one, two = 1, 2
    three, four = code.call(one, two)
    return "Give me a #{three} and a #{four}"
end

def square(n)
    n ** 2
end
array.iterate!(method(:square))
