# open a file and convert it into a list of whatever integer is on each line 
def read_file(filename)
    str_list = File.readlines(filename)
    return str_list.map{|x| x.to_i}.compact
end

def get_answer(filename)
    puts("Tie it all together here")
end

challenge_name = "e.g. 01a"

puts "test:"
get_answer("inputs/#{challenge_name}_test.txt")
puts "actual:"
get_answer("inputs/#{challenge_name}_real.txt")