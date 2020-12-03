class Map
    @@rise = 1
    @@run = 3
    def initialize(filename)
        initial_rows = Array.new
        initial_width = 0
        lines = File.readlines(filename, chomp: true)
        lines.each do | line |
            row = line.each_char.to_a
            initial_rows.push(row)
            if row.length > initial_width
                initial_width = row.length
            end
        end
        @height = initial_rows.length
        
        # how many cells across does it need to be to accomodate the descent? 
        width_needed = @@run * (@height.fdiv(@@rise)) # needs to move over run spaces, height/rise times
        # to reach that width, multiply the original column by this many times 
        width_multiplier = width_needed.fdiv(initial_width).ceil

        @rows = Array.new 
        initial_rows.each do | row | 
            new_row = row * width_multiplier
            @rows.push(new_row)
        end
    end
    def print
        @rows.each do |row|
            puts row.join("")
        end
    end
 end

def get_answer(filename)
    m = Map.new(filename)
    m.print
end

challenge_name = "03a"

puts "test:"
get_answer("inputs/#{challenge_name}_test.txt")
# puts "actual:"
# get_answer("inputs/#{challenge_name}_real.txt")