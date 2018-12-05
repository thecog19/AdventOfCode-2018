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

def test_all_polymers(string)
    all_chars = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    collapsed_value = {}
    all_chars.each do |char|
        p char
        test_string = string.delete(char)
        test_string = test_string.delete(char.upcase)
        collapsed_value[char] = polymer_destroyer(test_string)
    end
    collapsed_value.min_by{|k,v| v}[1]
end
