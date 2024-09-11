class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data = nil)
    self.data = data
    self.left_child = nil
    self.right_child = nil
  end

  def to_s
    puts "Data: #{data} Left Child: #{left_child} Right Child: #{right_child}"
  end
end
