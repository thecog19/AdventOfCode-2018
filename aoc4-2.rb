def generate_data(input)
    guard_hash = {}
    data = input.split("\n")
    data.sort! do |datum1, datum2| 
       base = datum1[6..7] <=> datum2[6..7]
       if(base == 0)
         base = datum1[9..10] <=> datum2[9..10]
       end 
       if(base == 0)
         base = datum1[12..13] <=> datum2[12..13]
       end 
       if(base == 0)
         base = datum1[15..16] <=> datum2[15..16]
       end 
       base 
    end
    curr_guard = false
    curr_arr = []
    asleep_start = -1
    data.each do |line|
        split_line = line.split(" ")
        instructions = split_line[2]
        day = split_line[0][9..10]
        hour_minute = split_line[1][0..4].split(":").map {|value| value.to_i}
        if instructions == "Guard"
            curr_guard = split_line[3] 
            guard_hash[curr_guard] = [] unless guard_hash[curr_guard]
            guard_hash[curr_guard].push(Array.new(60, "awake") )
        end
        curr_arr = guard_hash[curr_guard][-1]
        if instructions == "falls"
            asleep_start = hour_minute[1]
        end
        if instructions == "wakes"
            curr_arr.fill("asleep", asleep_start...hour_minute[1])
        end
    end
    guard_hash
end

def get_hash(input)
    guard_hash = generate_data(input)
    guard_to_minute = {}
    guard_to_times = {}
    guard_hash.each do |key, value|
        times = calculate_sleepiest_minute_and_count(key, guard_hash)
        if(times == nil)
            next
        end
        guard_to_minute[key] = times[0]
        guard_to_times[key] = times[1]
    end
    guard = guard_to_times.max_by{|k,v| v}[0]
    guard_to_minute[guard] *guard[1..-1].to_i
end

def calculate_sleepiest_minute_and_count(guard, guard_hash)
    schedule = guard_hash[guard]
    minutes = {}
    schedule.each do |day|
        day.each_with_index do |status, minute|
            if(status == "asleep")
                minutes[minute] = 0 unless(minutes[minute])
                minutes[minute] += 1
            end
        end
    end
    minutes.max_by{|k,v| v}
                
end
