require "byebug"
class PolyTreeNode
  attr_reader :parent, :children, :value
 def initialize(value)
  @value = value
  @parent = nil
  @children = []
 end

 def parent=(node)
   if !self.parent.nil?
    self.parent.children.delete(self) 
    @parent = node
    node.children << self unless node == nil
    else
     @parent = node
     node.children << self unless node == nil

   end
 end

 def add_child(node)
  node.parent = self
 end

 def remove_child(node)
  if node.parent != self
    raise "#{node} is no child of mine"
  else
  node.parent = nil
  end
 end

 def dfs(target)
  # debugger
   return self if self.value == target
  self.children.each do |child|
    # debugger
    search_target = child.dfs(target)
    return search_target unless search_target == nil
    end
    nil
  end

  def bfs(target)
    search_queue = []
    search_queue << self
    
    until search_queue.empty?
      if search_queue.first.value != target
       # debugger
        search_queue.first.children.each do | child |
       #   debugger
        search_queue.push(child)
        end
        search_queue.shift
      else
        return search_queue.first
      end
      
    end
    nil
  end
end