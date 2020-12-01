# open a file and convert it into a list of whatever integer is on each line 
def read_file(filename)
    str_list = IO.readlines(filename)
    return str_list.map{|x| x.to_i}.compact
end

# given a list of numbers, find a pair that adds to 2020
def find_pair(num_list)
    while num_list
        first = num_list.shift 
        for second in num_list do 
            if first + second == 2020
                return [first, second]
            end
        end 
    end
end

# tie it all together - open the file, process it into a list of ints, find the pair, and multiply it
def get_answer(filename)
    nums = read_file(filename)
    pair = find_pair(nums)
    puts "the numbers are #{pair[0]} and #{pair[1]}"
    product = pair[0] * pair[1]
    puts "the solution is #{product}"
end

puts "test:"
get_answer("inputs/01a_test.txt")
puts "actual:"
get_answer("inputs/01a_real.txt")