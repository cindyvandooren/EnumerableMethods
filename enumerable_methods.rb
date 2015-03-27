module Enumerable 
	def my_each	
		result = []	
		# if a block is given, make the changes in the array using the block
		if block_given?
			for i in self
				yield(i)
			end

		# if no block is given, return the unaltered array
		else
			return self
		end
	end

	def my_each_with_index
		# my_each should return the array itself, unless we want to make changes using a block
		return self unless block_given?

		# if there is a block, we allow the block to access the elements and the indices
		0.upto(self.length-1) {|i| yield(self[i], i)}
	end

	def my_select
		result = []
		# if there are no requirements/block, no items will get selected and the result is an empty array
		return self unless block_given?
		
		# if there is a block with requirements, we have to go through each element of the array
		# and add it to the result array if it meets the requirements
		self.my_each {|i| result << i if yield(i)}
		result 
	end

	def my_all?
		# if a block is given, iterate over elements of array
		# if any of them does not meet requirements of the block return false
		if block_given?
			self.my_each do |i|
				if yield(i) == false || yield(i) == nil
					return false
				end
			end
		
		# if there is no block, iterate over elements of array
		# return false if any of them evaluate to false or nill 
		else
			self.my_each do |i|
				if i == false || i == nil
					return false
				end
			end
		end

		# if by now the method hasn't returned false, it should return true
		return true
	end

	def my_any?
		# if a block is given, iterate over the elements of the array
		# if any of them meet the requirements of the block, return true
		if block_given?
			self.my_each do |i|
				if yield(i) == true
					return true
				end
			end

		# if no block is given, iterate over the elements of the array
		# return true if at least 1 of the elements evaluates to true
		else
			self.my_each do |i|
				if i == true
					return true
				end
			end
		end

		# if by now the method hasn't evaluated to true, it should return false
		return false
	end

	def my_none?
		# if a block is given, iterate over the element of the array
		# if any of them meet the requirements, return false
		if block_given?
			self.my_each do |i|
				if yield(i) == true
					return false
				end
			end

		# if no block is given, iterate over the elements of the array
		# return false if any of the elements evaluates to true
		else
			self.my_each do |i|
				if i == true
					return false
				end
			end
		end

		# if by now the method hasn't evaluated to false, it should return true
		return true
	end

	def my_count (*args)
		
		# if a block is given, iterate over the elements of the array
		# return the number of elements that meet the requirements of the block
		if block_given?
			self.my_select {|i| yield(i)}.size

		# if no block is given, check if arguments are given
		# if not, the method should return the size of the array
		elsif args.empty?
			return self.size

		# if an argument is given, the method should return the number of elements in the array
		# that are equal to the argument
		else
			self.my_select {|i| i == arg}.size
		end
	end

=begin

	def my_map
		result = []
		return self unless block_given?
		self.my_each {|i| result << i if yield(i)}
		result
	end

=end

	
	def my_map(proc=nil)
		result = []

		# if a proc is given, apply that to create new array
		if !proc == nil
			self.my_each {|i| result << i if proc.call(i)}

		# if no proc is given, but a block is given, apply that to create new array
		elsif block_given?
			self.my_each {|i| result << i if yield(i)}

		# if no proc or bloc are given, return array
		else
			return self
		end
	end

	def my_inject(start_value = nil)
		arg = start_value.nil? ? self[0] : start_value
		self.my_each {|i| arg = yield(arg, i)}
		arg
	end

	def multiple_els(array)
		array.my_inject(1){|product, a| product * a}
	end
end





