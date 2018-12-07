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
    @registy[value[0]]
end

def print_graph(root)
    p "b"
    queue = root.children
    string = ""
    string += root.name
    root.complete = true
    while !queue.empty?
        node = queue.shift
        if(node.complete)
            next
        end
        if(!node.parents)
            node.complete = true
        elsif(node.parents.all?{|parent| parent.complete == true})
            node.complete = true
        else
            queue.push(node)
            next
        end
        queue.concat(node.children)
        queue.sort!{|item1, item2| item1.name <=> item2.name}
        string += node.name
    end
    p string
    
end

generate_graph("Step C must be finished before step A can begin.
    Step C must be finished before step F can begin.
    Step A must be finished before step B can begin.
    Step A must be finished before step D can begin.
    Step B must be finished before step E can begin.
    Step D must be finished before step E can begin.
    Step F must be finished before step E can begin")
