class Node
    include Comparable
    attr_accessor :value, :left, :right

    def initialize(value)
        @value=value
        @left=nil
        @right=nil
        
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

    def is_leaf
        if @left == nil && @right ==nil
            return true
        else
            return false
        end
    end

    def find_min
        if @left==nil
            return self
        elsif left.is_leaf
            return left
        else
           min= left.find_min
        end
        return min
    end

    
end

class Tree

    attr :root

    def initialize(arr)
        arr.sort!
        arr.uniq!
        #puts arr
        @root=build_tree(arr)
        #puts @root
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
        #puts "left: #{parent.left} parent: #{parent} right: #{parent.right}"
        

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
    def delete(root,value)
       

        if root == nil
            
            return root

        elsif value<root.value
            
                left_val=delete(root.left,value)
                
                if left_val==nil
                    root.left= nil
                else
                    root.left=left_val
                end
            elsif value>root.value
               root.right=delete(root.right,value)
            
        else
            if root.is_leaf
                
                root = nil
                
                puts preorder
                
                
                
                
    
            elsif root.left==nil
                
                temp=root
                root=root.right
                temp = nil
                
            elsif root.right==nil
                
                temp=root
                root=root.left
                temp = nil
                
            else
                 
               
                temp_val  = root.right.find_min.value
                
                root.value=temp_val
                
                root.right=delete(root.right,temp_val)
                
            end
            
            return root

            
        end
       


    end

    def preorder(root=@root)
        
        if root == nil 
            return
        end
        puts root
        preorder(root.left)
        preorder(root.right)

    end
    def inorder(root=@root)
        


        if root==nil 
            return
        end
        inorder(root.left)
        puts root
        inorder(root.right)
    end

    def postorder(root=@root)
        if root==nil 
            return
        end
        postorder(root.left)
        postorder(root.right)
        puts root
    end            

    def level_order(root)
        node_queue=[]
        if root == nil
            return
        end

        node_queue.push(root)
        while node_queue.length>0
            current_node= node_queue.shift
            node_queue.push(current_node.left) unless current_node.left ==nil
            node_queue.push(current_node.right) unless current_node.right ==nil
            puts current_node
        end


    end

    def find(root=@root,value)
       

        if root == nil 
            return
        end

        if value==root.value
           puts "found"
           return root
            
        end
        
       res1= find(root.left,value)
       if res1 != nil
        return res1
       end

       res2= find(root.right,value)
       if res2 !=nil
        return res2
       end
        

        return "Item not found"
    end
    def depth(value,root=@root,height=0)
        if root==nil 
            return 0 
        end

        if root==value 
            return height 
        end
        
        level= depth(value,root.left,height+1)

        if level!=0 
            return level
         end

        return depth(value,root.right, height+1)

        
    end
end

arr=[7,5,6,3,2,1,8,10]
my_tree=Tree.new(arr)
# my_tree.insert(9)

# my_tree.delete(my_tree.root,3)
# puts "Preorder: "
# my_tree.preorder
# puts "Inorder: "
# my_tree.inorder

my_tree.level_order(my_tree.root)
puts my_tree.find(my_tree.root,12)
puts my_tree.depth(5)

