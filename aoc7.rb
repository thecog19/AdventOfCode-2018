@registy = {}
@is_parent = {}
Node = Struct.new(:name, :children, :parents, :complete) do 
    def insert_node(node)
        if(children)
            children.push(node)
            children.sort!{ |el1, el2| el1.name <=> el2.name}
        else
            children = [node]
        end
    end
end

def generate_graph(instructions)
    parent_child_pairs = instructions.split("\n").map{|instruction| [instruction.split(" ")[1], instruction.split(" ")[7]]}
    parent_child_pairs
    parent_child_pairs.each do |pair|
        p pair
        parent = pair[0]
        child = pair[1]
        @is_parent[child] = false
        if(@registy[parent])
            parent_node = @registy[parent]
        else
            parent_node = Node.new(parent, [], [], false)
            @registy[parent] = parent_node
        end
        if(@registy[child])
            child_node = @registy[child]
        else
            child_node = Node.new(child, [], [], false)
            @registy[child] = child_node
        end
        parent_node.insert_node(child_node)
        child_node.parents.push(parent_node)
    end
    print_graph(find_parent_node)
end

def find_parent_node
    value = @registy.keys - @is_parent.keys || @is_parent.keys - @registy.keys
    roots = []
    value.each do |root|
        roots.push(@registy[root])
    end
    return roots
end

def print_graph(roots)
    queue = []
    queue.concat(roots)
    string = ""
    queue.sort!{|item1, item2| item1.name <=> item2.name}
    backup_q = []
    while !queue.empty?
        node = queue.shift

        if(node.complete)
            next
        end
        if(!node.parents || node.parents.empty?)
            node.complete = true
        elsif(node.parents.all?{|parent| parent.complete == true})
            node.complete = true
        else
            backup_q.push(node)
            
            if(queue.empty?)
                queue.concat(backup_q)
                backup_q = []
            end
            next
        end
        queue.concat(node.children)
        queue.sort!{|item1, item2| item1.name <=> item2.name}
        string += node.name
    end
    p string
    
end
