require_relative 'lib/tree'
require 'pry-byebug'

arr = (Array.new(15) { rand(1..100) })

bst = Tree.new(arr)
bst.pretty_print

# puts(bst.post_order { |elem| elem.data = elem.data * 2 })
# bst.pretty_print

# puts bst.depth(bst.find(bst.root, 8))
bst.insert(bst.root, 105)
bst.insert(bst.root, 125)
bst.insert(bst.root, 154)
bst.insert(bst.root, 175)
bst.insert(bst.root, 192)
bst.insert(bst.root, 173)
bst.insert(bst.root, 149)
bst.insert(bst.root, 171)
bst.insert(bst.root, 185)
bst.insert(bst.root, 114)
bst.insert(bst.root, 137)

bst.pretty_print
puts bst.balanced?(bst.root)

bst.rebalance
bst.pretty_print
puts bst.balanced?(bst.root)
