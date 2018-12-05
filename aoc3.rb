@seen_before = 0

def execute(input)
    p get_overlap(generate_grid(input))
end


def get_overlap(grid)
    count = 0
    grid.each do |row|
        if(row)
            row.each do |ele| 
                count += 1 if(ele == "X")
            end
        end
    end
    count
end

def generate_grid(input)
    list = input.split("\n")
    grid = []
    list.each do |ele|
        values = ele.split(" ")
        coords = values[2].split(",").map { |coord| coord.to_i}
        dimensions = values[3].split("x").map { |dim| dim.to_i}
        grid = add_square(grid, coords, dimensions)
    end
    grid
end


def add_square(grid, coords, dimensions)
    @seen_before += 1
    dimensions[0].times do |horizontal|
        horizontal_coord = horizontal + coords[0]
        grid[horizontal_coord] = [] unless grid[horizontal_coord]
        dimensions[1].times do |vertical|
            vertical_coord = vertical + coords[1]
            coord_value = grid[horizontal_coord][vertical_coord]
            if(coord_value)
                grid[horizontal_coord][vertical_coord] = "X" 
            else
                grid[horizontal_coord][vertical_coord] = @seen_before
            end
        end
    end
    grid
end

def print_gird(grid)
    grid.each do |row|
        if(row)
            p row
        else 
            p [nil, nil, nil]
        end
    end
end
