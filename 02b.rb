# open a file and return the lines
def read_file(filename)
    str_list = File.readlines(filename)
    return str_list
end

def evaluate_password?(first, second, required_letter, password)
    # required_letter must occur either at first or at second - not both 
    letter_at_first = password[first-1]
    letter_at_second = password[second-1]
    return (letter_at_first.eql? required_letter) ^ (letter_at_second.eql? required_letter)
end

def parse_line(line)
    return /(?<first>\d+)-(?<second>\d+) (?<required_letter>\w): (?<password>\w+)/.match(line)
end

def get_answer(filename)
    valid_passwords = 0
    File.readlines(filename).each do |line|
        parsed = parse_line(line)
        first = parsed[:first].to_i
        second = parsed[:second].to_i
        required_letter = parsed[:required_letter]
        password = parsed[:password]

        if evaluate_password?(first, second, required_letter, password)
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