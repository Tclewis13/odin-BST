require_relative 'node'
require 'pry-byebug'

class Tree
  attr_accessor :arr, :root

  def initialize(arr)
    self.arr = prep_array(arr)
    self.root = build_tree(self.arr, 0, self.arr.length - 1)
  end

  def prep_array(arr)
    arr = arr.sort
    arr.uniq
  end

  def build_tree(arr, start, stop)
    return nil if start > stop

    mid = (start + stop) / 2
    root = Node.new(arr[mid])

    root.left_child = build_tree(arr, start, mid - 1)
    root.right_child = build_tree(arr, mid + 1, stop)
    root
  end

  def rebalance
    new_array = pre_order
    self.arr = new_array
    self.root = build_tree(new_array, 0, new_array.length - 1)
  end

  def print_preorder(node)
    return nil if node.nil?

    print node.data
    print_preorder(node.left_child)
    print_preorder(node.right_child)
  end

  def get_successor(temp_node)
    temp_node = temp_node.right_child
    temp_node = temp_node.left_child while !temp_node.nil? && !temp_node.left_child.nil?
    temp_node
  end

  def insert(root, value)
    return Node.new(value) if root.nil?

    return root if root.data == value

    root.left_child = insert(root.left_child, value) if value < root.data
    root.right_child = insert(root.right_child, value) if value > root.data

    root
  end

  def find(node, value)
    return node if node.nil?
    return node if node.data == value

    return find(node.left_child, value) if node.data > value

    find(node.right_child, value)
  end

  def delete(root, value)
    return nil if root.nil?

    if root.data > value then root.left_child = delete(root.left_child, value)
    elsif root.data < value then root.right_child = delete(root.right_child, value)
    else
      return root.right_child if root.left_child.nil?
      return root.left_child if root.right_child.nil?

      successor = get_successor(root)
      root.data = successor.data
      root.right_child = delete(root.right_child, successor.data)
    end
    root
  end

  def inorder
    queue = [@root]
    result = []
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : result << node.data
      queue << node.left_child unless node.left_child.nil?
      queue << node.right_child unless node.right_child.nil?
    end
    result unless block_given?
  end

  def level_order(node = @root)
    return if node.nil?

    output = []
    queue = []
    queue << node
    until queue.empty?
      current = queue.shift
      block_given? ? yield(current) : output << current.data
      queue << (current.left_child) if current.left_child
      queue << (current.right_child) if current.right_child
    end

    output
  end

  def pre_order(node = @root, output = [], &block)
    return if node.nil?

    block_given? ? block.call(node) : output << node.data
    pre_order(node.left_child, output, &block)
    pre_order(node.right_child, output, &block)

    output
  end

  def post_order(node = @root, output = [], &block)
    return if node.nil?

    post_order(node.left_child, output, &block)
    post_order(node.right_child, output, &block)
    block_given? ? block.call(node) : output << node.data

    output
  end

  def height(root)
    return 0 if root.nil?

    left_height = height(root.left_child)
    right_height = height(root.right_child)
    return left_height + 1 if left_height > right_height

    right_height + 1
  end

  def balanced?(root)
    height_left = height(root.left_child)
    height_right = height(root.right_child)

    (height_left - height_right).between?(-1, 1) ? true : false
  end

  def depth(node)
    height(@root) - height(node)
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
