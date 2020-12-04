REQUIRED_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

def get_passport_hash(passport_string)
    result = Hash.new
    result[:complete] = true
    REQUIRED_FIELDS.each do | field |
        match = /#{field}:(#?\w+)/.match(passport_string)
        if match == nil
            result[:complete] = false
            puts "#{field} missing from #{passport_string}"
        else
            result[field] = match
        end
    end 
    return result 
end


# this time, return them as a list of associative arrays/hashes
def get_passports(filename)
    passports = Array.new
    current_passport_string = ""
    File.readlines(filename, chomp: true).each do |line|
        stripped_line = line.strip 
        if stripped_line == ""
            passport_hash = get_passport_hash(current_passport_string)
            passports.push(passport_hash)
            current_passport_string = ""
        else
            current_passport_string += " #{stripped_line} "
        end
    end
    passport_hash = get_passport_hash(current_passport_string)
    passports.push(passport_hash)
    return passports
end

def validate_passports(passports)
    passports.each do | p |
        puts p 
    end
end

def get_answer(filename)
    passports = get_passports(filename)
    answer = validate_passports(passports)
    # puts "valid count: #{answer}"
end

challenge_name = "04b"

puts "test:"
get_answer("inputs/#{challenge_name}_test.txt")
# puts "fischer:" # asked a coworker to help by giving me the first 50 passwords and the results they got
# get_answer("inputs/#{challenge_name}_fischer.txt")
# puts "actual:"
# get_answer("inputs/#{challenge_name}_real.txt")