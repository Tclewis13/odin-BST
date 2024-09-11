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

  def print_preorder(node)
    return nil if node.nil?

    print node.data
    print_preorder(node.left_child)
    print_preorder(node.right_child)
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
