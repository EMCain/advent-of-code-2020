REQUIRED_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

def get_passport_hash(passport_string)
    result = Hash.new
    result[:complete] = true
    REQUIRED_FIELDS.each do | field |
        match = /#{field}:(#?\w+[cm|in]?)/.match(passport_string)
        if match == nil
            result[:complete] = false
        else
            result[field] = match[1]
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
    puts "#{passports.length} total passports"
    return passports
end

def validate_field(fieldname, value)
    begin
        case fieldname
        when "byr"
            return value.to_i.between?(1920, 2002)
        when "iyr"
            return value.to_i.between?(2010, 2020)
        when "eyr"
            return value.to_i.between?(2020, 2030)
        when "hgt"
            match = /^(?<num>\d+)(?<unit>\w+)?/.match(value)
            if match[:unit] == "cm"
                return match[:num].to_i.between?(150, 193)
            elsif match[:unit] == "in"
                return match[:num].to_i.between?(59, 76)
            else
                return false
            end
        when "hcl"
            return /^#([\d|[a-f]]{6})$/.match(value) != nil
        when "ecl"
            return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include? value
        when "pid"
            return /^(\d{6})?/.match(value) != nil
        when "cid"
            return true
        end
    rescue
        return false
    end
end

def validate_passports(passports)
    valid_passports = 0
    passports.each do | p |
        valid = 1
        REQUIRED_FIELDS.each do |field|
            if not validate_field(field, p[field])
                valid = 0
            end
        end
        valid_passports += valid
    end
    return valid_passports
end

def get_answer(filename)
    passports = get_passports(filename)
    answer = validate_passports(passports)
    puts "valid count: #{answer}"
end

challenge_name = "04b"

puts "test:"
get_answer("inputs/#{challenge_name}_test.txt")

# puts "fischer:" # asked a coworker to help by giving me the first 50 passwords and the results they got
# get_answer("inputs/#{challenge_name}_fischer.txt")


challenge_name = "04a"
puts "actual:"
get_answer("inputs/#{challenge_name}_real.txt")