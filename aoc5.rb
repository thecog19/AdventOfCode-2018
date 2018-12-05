def polymer_destroyer(input)
    iterations = 0
    new_str = input.split('')
    curr_str = input.split('')
    while true
        to_delete = []
        
        len = curr_str.length
        delete = false
        curr_str.each_with_index do |char, ind|
            next if ind  == len -1
            if delete
                delete = false 
                next
            end
            next if(char == curr_str[ind + 1])
            if(char.downcase == curr_str[ind + 1].downcase)
                to_delete.push([ind, ind+1])
                delete = true
            end
        end
        shift = 0
        to_delete.each do |deletion|
            new_str.slice!((deletion[0] - shift).. (deletion[1] - shift))
            shift += 2
        end
        if(curr_str == new_str)
            return new_str.join("").length
        end
        curr_str = new_str.clone
        iterations += 1
    end
end
