import UIKit

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class StackSolution {
    /*
     二叉树的前序遍历（根->左->右)
     [1,null,2,3] -> [1,2,3]
     */
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        var stack: [TreeNode] = []
        var cur = root
        
        while !stack.isEmpty || cur != nil {
            if (cur != nil) {
                result.append(cur!.val)
                stack.append(cur!)
                cur = cur!.left
            } else {
                cur = stack.removeLast().right
            }
        }
        
        return result
    }
    
    /*
     二叉树的中序遍历（左->根->右)
     [1,null,2,3] -> [1,3,2]
     */
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        var stack: [TreeNode] = []
        var cur = root
        
        while !stack.isEmpty || cur != nil {
            if (cur != nil) {
                stack.append(cur!)
                cur = cur!.left
            } else {
                cur = stack.removeLast()
                result.append(cur!.val)
                cur = cur!.right
            }
        }
        
        return result
    }
    
    /*
     二叉树的后序遍历(左->右->根)
     [1,null,2,3] -> [3,2,1]
     */
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        var stack: [TreeNode] = []
        var tagStack: [Int] = []
        var cur = root
        
        while !stack.isEmpty || cur != nil {
            while cur != nil {
                stack.append(cur!)
                tagStack.append(0)
                cur = cur!.left
            }
            while !stack.isEmpty && tagStack.last! == 1 {
                tagStack.removeLast()
                result.append(stack.removeLast().val)
            }
            if !stack.isEmpty {
                tagStack.removeLast()
                tagStack.append(1)
                cur = stack.last!.right
            }
        }
        
        return result
     }
    
    /*
     层次遍历，广度优先遍历
     [3,9,20,null,null,15,7] -> [[3], [9,20], [15,7]]
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result: [[Int]] = []
        var queue: [TreeNode] = []
        if let root = root {
            queue.append(root)
        }
        while queue.count > 0 {
            let size = queue.count
            var level: [Int] = []
            for _ in 0 ..< size {
                let node = queue.removeFirst()
                level.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            result.append(level)
        }
        
        return result
    }
}

// 递归思路
class RecursiveSolution {
    /*
     二叉树的最大深度
     [3,9,20,null,null,15,7] -> 3
     */
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        return max(maxDepth(root.left), maxDepth(root.right)) + 1
    }
    
    // 前序遍历二叉树
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        _preHelper(root, &result)
        return result
    }
    
    func _preHelper(_ node: TreeNode?, _ res: inout [Int]) {
        guard let node = node else { return }
        res.append(node.val)
        _preHelper(node.left, &res)
        _preHelper(node.right, &res)
    }
    
    // 中序遍历二叉树
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        _inHelper(root, &result)
        return result
    }
    
    func _inHelper(_ node: TreeNode?, _ res: inout [Int]) {
        guard let node = node else { return }
        _inHelper(node.left, &res)
        res.append(node.val)
        _inHelper(node.right, &res)
    }
    
    // 后序遍历二叉树
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        _postHelper(root, &result)
        return result
    }
    
    func _postHelper(_ node: TreeNode?, _ res: inout [Int]) {
        guard let node = node else { return }
        _postHelper(node.left, &res)
        _postHelper(node.right, &res)
        res.append(node.val)
    }
    
    /*
     对称二叉树
     [1,2,2,3,4,4,3] -> true
     [1,2,2,null,3,null,3] -> false
     */
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        return isSymmetricHelper(root.left, root.right)
    }
    
    func isSymmetricHelper(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        
        if let left = left, let right = right, left.val == right.val {
            return isSymmetricHelper(left.left, right.right) && isSymmetricHelper(left.right, right.left)
        } else {
            return false
        }
    }
    
    /*
     路径总和
     [5,4,8,11,null,13,4,7,2,null,null,null,1] -> 22
     */
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard let root = root else { return false }
        if sum == root.val && root.left == nil && root.right == nil {
            return true
        }
        
        return hasPathSum(root.left, sum - root.val) || hasPathSum(root.right, sum - root.val)
    }
    
    // 从中序与后序遍历序列构造二叉树
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        if (inorder.count == 0 || postorder.count == 0) {
            return nil
        }
        return buildTreeHelper(inorder, 0, inorder.count - 1, postorder, 0, postorder.count - 1)
    }
    
    func buildTreeHelper(_ inorder: [Int], _ i_start: Int, _ i_end: Int, _ postorder: [Int], _ p_start: Int, _ p_end: Int) -> TreeNode? {
        if i_end < i_start || p_end < p_start {
            return nil
        }
        
        let root = TreeNode(postorder[p_end])
        let pos = findRoot(root.val, inorder, i_start, i_end)
        let leftLen = pos - i_start
        let rightLen = i_end - pos
        
        if leftLen > 0 {
            root.left = buildTreeHelper(inorder, i_start, i_start + leftLen - 1, postorder, p_start, p_start + leftLen - 1)
        }
        if rightLen > 0 {
            root.right = buildTreeHelper(inorder, i_end - rightLen + 1, i_end, postorder, p_end - rightLen, p_end - 1)
        }
        
        return root
    }
    
    func findRoot(_ rootVal: Int, _ inorder: [Int], _ i_start: Int, _ i_end: Int) -> Int {
        for i in i_start...i_end {
            if inorder[i] == rootVal {
                return i
            }
        }
        return -1
    }
    
    // 从前序与中序遍历序列构造二叉树
    func buildTree1(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if (preorder.count == 0 || inorder.count == 0) {
            return nil
        }
        
        return buildTreeHelper1(preorder, 0, preorder.count - 1, inorder, 0, inorder.count - 1)
    }
    
    func buildTreeHelper1(_ preorder: [Int], _ p_start: Int, _ p_end: Int, _ inorder: [Int], _ i_start: Int, _ i_end: Int) -> TreeNode? {
        if p_end < p_start || i_end < i_start {
            return nil
        }
        
        let root = TreeNode(preorder[p_start])
        let pos = findRoot1(root.val, inorder, i_start, i_end)
        let leftLen = pos - i_start
        let rightLen = i_end - pos
        
        if leftLen > 0 {
            root.left = buildTreeHelper1(preorder, p_start + 1, p_end - rightLen, inorder, i_start, i_start + leftLen - 1)
        }
        
        if rightLen > 0 {
            root.right = buildTreeHelper1(preorder, p_start + leftLen + 1, p_end, inorder, i_end - rightLen + 1, i_end)
        }
        
        return root
    }
    
    func findRoot1(_ rootVal: Int, _ inorder: [Int], _ i_start: Int, _ i_end: Int) -> Int {
        for i in i_start...i_end {
            if inorder[i] == rootVal {
                return i
            }
        }
        return -1
    }
    
    /*
     二叉树的最近公共祖先
     [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1 -> 3
     */
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || p === root || q === root { return root }
        
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left == nil { return right }
        if right == nil { return left }
        return root
    }
    
    // 二叉树的序列化与反序列化
    func serialize(_ root: TreeNode?) -> String {
        guard let root = root else { return "" }
        
        var res = ""
        var nodes: [TreeNode?] = [root]
        
        while !nodes.isEmpty {
            let currentLevelSize = nodes.count
            
            for _ in 0..<currentLevelSize {
                let node = nodes.removeFirst()
                
                if let node = node {
                    res.append(String(node.val))
                    
                    nodes.append(node.left)
                    nodes.append(node.right)
                } else {
                    res.append("#")
                }
                res.append(",")
            }
        }
        
        res.remove(at: res.index(before: res.endIndex))
        return res
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        let vals = data.components(separatedBy: ",")
        guard let firstVal = vals.first, let rootVal = Int(String(firstVal)) else {
            return nil
        }
        
        let root = TreeNode(rootVal)
        var nodes: [TreeNode?] = [root]
        var i = 1
        
        while !nodes.isEmpty {
            guard let node = nodes.removeFirst() else {
                continue
            }
            
            var left: TreeNode?
            if let leftVal = Int(String(vals[i])) {
                left = TreeNode(leftVal)
            }
            node.left = left
            nodes.append(left)
            i += 1
            
            var right: TreeNode?
            if let rightVal = Int(String(vals[i])) {
                right = TreeNode(rightVal)
            }
            node.right = right
            nodes.append(right)
            i += 1
        }
        
        return root
    }
}

public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}

class Solution {
    // 填充每个节点的下一个右侧节点指针I
    func connect(_ root: Node?) -> Node? {
        guard let root = root else { return nil }
        
        if let left = root.left {
            left.next = root.right
        }

        if let next = root.next, let right = root.right {
            right.next = next.left
        }

        connect(root.left)
        connect(root.right)

        return root
    }
    
    // 填充每一个人节点的下一个右侧节点指针II
    func connectII(_ root: Node?) -> Node? {
        guard let root = root else { return nil }
            
        if let left = root.left {
            if let right = root.right {
                left.next = right
            } else {
                left.next = getNext(root.next)
            }
        }

        if let right = root.right {
            right.next = getNext(root.next)
        }

        connect(root.right)
        connect(root.left)

        return root
    }

    func getNext(_ root: Node?) -> Node? {
        guard let root = root else { return nil }

        if let left = root.left {
            return left
        } else if let right = root.right {
            return right
        } else if let next = root.next {
            return getNext(next)
        }

        return nil
    }
}


