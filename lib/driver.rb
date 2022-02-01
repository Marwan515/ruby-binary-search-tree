require_relative 'search_tree'

random_arr = (Array.new(15) { rand(1...100)})
my_tree = Tree.new(random_arr)

puts "Balance CHECK?"
puts my_tree.balanced?

puts "\n"

puts "Level Order CHECK?"
my_tree.level_order {|i| puts i}

puts "Preorder CHECK?"
my_tree.preorder {|i| puts i}

puts "Postorder CHECK?"
my_tree.postorder {|i| puts i}

puts "Inorder CHECK?"
my_tree.inorder {|i| puts i}

my_tree.insert_v(120)
my_tree.insert_v(123)
my_tree.insert_v(145)
puts my_tree.balanced?

my_tree.rebalance

puts my_tree.balanced?

puts "Level Order CHECK?"
my_tree.level_order {|i| puts i}

puts "Preorder CHECK?"
my_tree.preorder {|i| puts i}

puts "Postorder CHECK?"
my_tree.postorder {|i| puts i}

puts "Inorder CHECK?"
my_tree.inorder {|i| puts i}