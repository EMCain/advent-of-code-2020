REQUIRED_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

def get_passports(filename)
    passports = Array.new
    current_passport = ""
    File.readlines(filename, chomp: true).each do |line|
        stripped_line = line.strip 
        if stripped_line == ""
            passports.push(current_passport)
            current_passport = ""
        else
            current_passport += " #{stripped_line} "
        end
    end
    passports.push(current_passport)
    return passports
end

def validate_passports(passports)
    valid_count = 0
    passports.each do | p |
        valid = 1 
        missing = Array.new
        REQUIRED_FIELDS.each do | field |
            if ! p.include? field
                valid = 0
                missing.push(field)
            end
        end
        end
        valid_count += valid
    end
    return valid_count
end

def get_answer(filename)
    passports = get_passports(filename)
    answer = validate_passports(passports)
    puts "valid count: #{answer}"
end

challenge_name = "04a"

puts "test:"
get_answer("inputs/#{challenge_name}_test.txt")
puts "fischer:" # asked a coworker to help by giving me the first 50 passwords and the results they got
get_answer("inputs/#{challenge_name}_fischer.txt")
puts "actual:"
get_answer("inputs/#{challenge_name}_real.txt")