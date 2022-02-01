class Node
    attr_accessor :data, :left, :right

    def initialize(data, left = nil, right = nil)
        @data = data
        @left = left
        @right = right
    end

end

class Tree

    def initialize(arr)
        arr = arr.uniq.sort
        @root = build_tree(arr)
    end

    def build_tree(arr, start = arr[0], lst = arr.length - 1)
        return nil if start > lst
        center = (start + lst) / 2
        root_v = Node.new(arr[center])

        root_v.left = build_tree(arr, start, center-1)
        root_v.right = build_tree(arr, center + 1, lst)

        root_v
    end

    def insert_v(value, node = @root)
        return nil if value == node.data

        if value < node.data
            if node.left.nil?
                node.left = Node.new(value)
            else
                insert_v(value, node.left)
            end
        else
            if node.right.nil?
                node.right = Node.new(value)
            else
                insert_v(value, node.right)
            end
        end
    end

    def delete(value, node = @root)
        return nil if node.nil?

        if value > node.data
            node.right = delete(value, node.right)
        elsif value < node.data
            node.left = delete(value, node.left)
        end

        if value == node.data
            if !node.right.nil?
                y = right_lowest(node.right)
                node.data = y.data
                y.data = nil
                puts "Value Replaced by #{node.data}"
            elsif !node.left.nil?
                y = left_highest(node)
                node.data = y.data
                y.data = nil
                puts "Value Replaced by #{node.data}"
            else
                node.data = nil
                puts "Empty Binary Tree HUH!"
            end
            
        end
    end

    def left_highest(current_node = @root)
        return current_node if current_node.right.nil? && current_node.left.nil?
        current_node = current_node.right while !current_node.right.nil?
        left_highest(current_node)
    end

    def right_lowest(current_node = @root)
        return current_node if current_node.right.nil? && current_node.left.nil?
        current_node = current_node.left while !current_node.left.nil?
        if !current_node.right.nil?
            current_node = current_node.right
        end
        right_lowest(current_node)
    end

    def find(value, node = @root)
        return puts "ERROR DOESN'T EXIST" if node.nil?
        if value == node.data
            return node
        end

        if value > node.data
            find(value, node.right)
        elsif value < node.data
            find(value, node.left)
        end
    end

    def level_order(node = @root)
        address = []
        address << node
        for i in address
            if i.right.nil? && !i.left.nil?
                address << i.left
            elsif i.left.nil? && !i.right.nil?
                address << i.right
            elsif !i.right.nil? && !i.left.nil?
                address << i.left
                address << i.right
            else
                next
            end
        end
        if block_given?
            for i in address
                yield i.data
            end
        else
            return address
        end
    end

    def inordered(node = @root, list = [])
        return list if node.nil?
    
        inordered(node.left, list)
        list << node
        inordered(node.right, list)
    end

    def inorder()
        l = inordered()
        j = []
        for i in l
            j << i.data
        end
        if block_given?
            for v in j
                yield v
            end
        else
            return j
        end
    end

    def preordered(node = @root, list = [])
        return list if node.nil?

        list << node
        preordered(node.left, list)
        preordered(node.right, list)
    end

    def preorder
        l = preordered()
        j = []
        for i in l
            j << i.data
        end
        if block_given?
            for v in j
                yield v
            end
        else
            return j
        end
    end

    def postordered(node = @root, list = [])
        return list if node.nil?

        postordered(node.left, list)
        postordered(node.right, list)
        list << node
    end

    def postorder
        l = postordered()
        j = []
        for i in l
            j << i.data
        end
        if block_given?
            for v in j
                yield v
            end
        else
            return j
        end
    end

    def heighted(node = @root)
        return 0 if node.nil?
        left_c = node.left ? heighted(node.left) : 0
        right_c = node.right ? heighted(node.right) : 0
        left_c > right_c ? left_c + 1 : right_c + 1
    end

    def height(value)
        v = find(value)
        heighted(v)
    end

    def depth(value)
        v = find(value)
        r = heighted(v.right) + 1
        l = heighted(v.left) + 1
        return l + r
    end

    def balanced?(node = @root)
        return true if node.nil?

        lh = heighted(node.left)
        rh = heighted(node.right)
        if (lh - rh).abs <= 1 && balanced?(node.left) && balanced?(node.right)
            return true
        end

        return false
    end

    def rebalance
        arr = inorder()
        @root = build_tree(arr)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

end