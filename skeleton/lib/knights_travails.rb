require_relative "00_tree_node.rb"

class KnightPathFinder
  attr_reader :consider_positions, :root_node, :pos
  DELTAS = [ 
    [2,1],
    [1,2],
    [-1,2],
    [-2,1],
    [-1,-2],
    [-2,-1],
    [2,-1],
    [1,-2]


  ]
  def initialize(pos)
    @pos = pos
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
  end

  def build_move_tree
    queue = []
    queue << self.root_node
    until queue.empty?
      current_root = queue.shift
      
    children_values = new_move_positions(current_root.value)
    
    children_values.each do |child_value|
      current_root.add_child(PolyTreeNode.new(child_value))
    end
    current_root.children.each do |child|
      queue << child
    end
    # self.root_node.add_child(new_move_positions(self.root_node.value))
    
   
    # self.root_node.add_child(new_move_positions(self.pos))
    end 
    self.root_node
  end
  
  def new_move_positions(pos)
    new_moves = []
    valid_moves = KnightPathFinder.valid_moves(pos)
   # debugger
    valid_moves.each do | move |
      if !@considered_positions.include?(move)
          @considered_positions << move
          new_moves << move
      end
    end
    new_moves
  end


  def self.valid_moves(pos)
    valid_moves = []
    x, y = pos
    DELTAS.each do |move|
      deltas_x = move[0]
      deltas_y = move[1]
      possible_move = [x + deltas_x, y + deltas_y]
      if possible_move[0] >= 0 && possible_move[0] <= 7 && possible_move[1] >= 0 && possible_move[1] <= 7
        valid_moves << possible_move
      end
    end
    valid_moves
  end
  
  def find_path(end_pos)
    self.root_node.dfs(end_pos)
  end

  def trace_path_back(end_pos)
   end_node = find_path(end_pos)
    path = [end_node]
    until path.first.parent == nil
       path.unshift(path.first.parent)
      # path << self.root_node.parent.value
    end
    path.map { |node| node.value }
  end
  
end

kk = KnightPathFinder.new([0,0])
kk.build_move_tree
# p kk.find_path([6,3]).value
p kk.trace_path_back([6,3])
