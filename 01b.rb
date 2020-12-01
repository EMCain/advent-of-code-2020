# open a file and convert it into a list of whatever integer is on each line 
def read_file(filename)
    str_list = IO.readlines(filename)
    return str_list.map{|x| x.to_i}.compact
end

# given a list of numbers, find three that add to 2020
def find_triple(num_list)
    while num_list
        first = num_list.shift 
        for second in num_list do 
            remaining = num_list[1..-1]
            remaining.each do |third|
                if first + second + third == 2020
                    return [first, second, third]
                end
            end
        end 
    end
end

# tie it all together - open the file, process it into a list of ints, find the triple, and multiply them
def get_answer(filename)
    nums = read_file(filename)
    pair = find_triple(nums)
    puts "the numbers are #{pair[0]}, #{pair[1]} and #{pair[2]}"
    product = pair[0] * pair[1] * pair[2]
    puts "the solution is #{product}"
end

puts "test:"
get_answer("inputs/01a_test.txt")
puts "actual:"
get_answer("inputs/01a_real.txt")