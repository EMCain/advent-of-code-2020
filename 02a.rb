# open a file and return the lines
def read_file(filename)
    str_list = File.readlines(filename)
    return str_list
end

# from https://stackoverflow.com/a/25938828
def count_em(string, substring)
    string.each_char.each_cons(substring.size).map(&:join).count(substring)
end

def evaluate_password?(min, max, required_letter, password)
    count = count_em(password, required_letter) 
    return count.between?(min, max)
end

def parse_line(line)
    return /(?<min>\d+)-(?<max>\d+) (?<required_letter>\w): (?<password>\w+)/.match(line)
end

def get_answer(filename)
    valid_passwords = 0
    File.readlines(filename).each do |line|
        parsed = parse_line(line)
        min = parsed[:min].to_i
        max = parsed[:max].to_i
        required_letter = parsed[:required_letter]
        password = parsed[:password]

        if evaluate_password?(min, max, required_letter, password)
            valid_passwords += 1
        end
    end
    return valid_passwords
end

challenge_name = "02a"

puts "test:"
puts get_answer("inputs/#{challenge_name}_test.txt")
puts "actual:"
puts get_answer("inputs/#{challenge_name}_real.txt")