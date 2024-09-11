require_relative 'lib/tree'
require 'pry-byebug'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

bst = Tree.new(arr)
bst.pretty_print
