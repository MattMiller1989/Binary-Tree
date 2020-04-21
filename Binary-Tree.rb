class Node
    include Comparable
    attr_accessor :value, :left, :right, :parent

    def initialize(value)
        @value=value
        @left=nil
        @right=nil
        @parent=nil
    end

    def <=>(other)
        if other.is_a? Node
            @value <=> other.value
          else
            @value <=> other
          
        end
    end

    def to_s
        return @value.to_s
    end


end

class Tree

    attr :root

    def initialize(arr)
        arr.sort!
        arr.uniq!
        puts arr
        @root=build_tree(arr)
        puts @root
    end

    def build_tree(arr)
        #puts arr
        mid =(arr.length/2).floor
        parent=Node.new(arr.slice!(mid,1)[0])
        #puts par
        if arr.length == 0
            return parent
        end
        

        left_arr=arr[0..mid-1]
        #left_mid=(left_arr.length/2).floor
         right_arr=arr[mid..arr.length]
        # right_mid=(right_arr.length/2).floor

        parent.left=build_tree(left_arr)
        parent.right=build_tree(right_arr)
        puts "left: #{parent.left} parent: #{parent} right: #{parent.right}"
        

        return parent
    end
    
    def insert(root=@root, value)
        #puts root.class
        temp_node=Node.new(value)

        if temp_node<root
            if(root.left==nil)
                root.left=temp_node
            else
                insert(root.left,value)
            end
        elsif temp_node>root
            if(root.right==nil)
                root.right=temp_node
            else
                insert(root.right,value)
            end
        end

        
            
    end
            

end

arr=[7,5,6,3,2,1,8,10]
my_tree=Tree.new(arr)
my_tree.insert(4)
