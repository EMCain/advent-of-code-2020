class Map
    def initialize(filename, rise, run)
        @rise = rise
        @run = run
        @x_across = 0
        @y_down = 0  # technically an inverted y axis 

        initial_rows = Array.new
        initial_width = 0
        lines = File.readlines(filename, chomp: true)
        lines.each do | line |
            row = line.strip.each_char.to_a
            initial_rows.push(row)
            if row.length > initial_width
                initial_width = row.length
            end
        end
        @height = initial_rows.length
        
        # how many cells across does it need to be to accomodate the descent? 
        width_needed = @run * (@height.fdiv(@rise)) # needs to move over run spaces, height/rise times
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

    def value_at_coords
        row = @rows[@y_down]
        if row == nil
            return nil 
        end  
        value = row[@x_across]
        return value
    end

    def step
        @y_down += @rise
        @x_across += @run
        return value_at_coords
    end 
 end

def calculate_total(filename, rise, run)
    m = Map.new(filename, rise, run)
    value = m.value_at_coords
    total = 0
    while value != nil
        value = m.step
        if value == "#"
            total += 1
        end
    end 
    puts "total for #{rise}, #{run} is #{total}"
    return total
end

def get_answer(filename)
    a = calculate_total(filename, 1, 1)
    b = calculate_total(filename, 1, 3)
    c = calculate_total(filename, 1, 5)
    d = calculate_total(filename, 1, 7)
    e = calculate_total(filename, 2, 1)
    puts "answer is #{a*b*c*d*e}"
end 

challenge_name = "03a"

puts "test:"
get_answer("inputs/#{challenge_name}_test.txt")
puts "actual:"
get_answer("inputs/#{challenge_name}_real.txt")