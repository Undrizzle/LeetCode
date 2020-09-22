import UIKit

class Solution {
    /*
     删除数组中的重复元素
     [0,0,1,1,1,2,2,3,3,4] -> [0,1,2,3,4,2,2,3,3,4]
     */
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 1 else { return nums.count }
        
        var i = 0
        for j in 1..<nums.count {
            if nums[j] != nums[i] {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i + 1
    }
    
    /*
     买卖股票的最佳时机II
     [7,1,5,3,6,4] -> 7
     */
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else { return 0 }
        
        var maxProfit = 0
        for i in 0..<prices.count-1 {
            if prices[i] < prices[i+1] {
                maxProfit += prices[i+1] - prices[i]
            }
        }
        
        return maxProfit
    }
    
    /*
     旋转数组
     [1,2,3,4,5,6,7], k = 3 -> [5,6,7,1,2,3,4]
     */
    //暴力解法
    func rotate1(_ nums: inout [Int], _ k: Int) {
        guard nums.count > 1 else { return }
        var previous, temp: Int
        for _ in 0..<k {
            previous = nums[nums.count - 1]
            for j in 0..<nums.count {
                temp = nums[j]
                nums[j] = previous
                previous = temp
            }
        }
    }
    //使用额外的数组
    func rotate2(_ nums: inout [Int], _ k: Int) {
        guard nums.count > 1 else { return }
        let aa = nums
        let k = k % nums.count
        for i in 0..<nums.count {
            nums[(i+k) % nums.count] = aa[i]
        }
    }
    
    /*
     存在重复元素
     [1,2,3,1] -> true
     [1,2,3,4] -> false
     */
    func containsDuplicate(_ nums: [Int]) -> Bool {
        return Set<Int>(nums).count != nums.count
    }
    
    /*
     只出现一次的数字
     [2,2,1] -> 1
     */
    func singleNumber(_ nums: [Int]) -> Int {
        return nums.reduce(0, ^)
    }
    
    /*
     两个数组的交集II
     [1,2,2,1], [2,2] -> [2,2]
     */
    //双指针
    func intersect1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        guard nums1.count > 0, nums2.count > 0 else { return [] }
        
        let nums1 = nums1.sorted()
        let nums2 = nums2.sorted()
        var i = 0
        var j = 0
        var result = [Int]()
        
        while i < nums1.count && j < nums2.count {
            if nums1[i] < nums2[j] {
                i += 1
            } else if nums1[i] == nums2[j] {
                result.append(nums1[i])
                i += 1
                j += 1
            } else if nums1[i] > nums2[j] {
                j += 1
            }
        }
        
        return result
    }
    
    //哈希表
    func intersect2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        guard nums1.count > 0, nums2.count > 0 else { return [] }
        
        var result = [Int]()
        var numMap = [Int: Int]()
        
        for num1 in nums1 {
            if let record_num = numMap[num1] {
                numMap[num1] = record_num + 1
            } else {
                numMap[num1] = 1
            }
        }
        
        for num2 in nums2 {
            if var record_num = numMap[num2] {
                record_num -= 1
                numMap[num2] = record_num
                result.append(num2)
                if (record_num == 0) {
                    numMap.removeValue(forKey: num2)
                }
            }
        }
        
        return result
    }
    
    /*
     移动零
     [0,1,0,3,12] -> [1,3,12,0,0]
     */
    func moveZeros(_ nums: inout [Int]) {
        var j = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums.swapAt(i, j)
                j += 1
            }
        }
    }
    
    /*
     加一
     [1,2,3] -> [1,2,4]
     */
    func plusOne(_ digits: [Int]) -> [Int] {
        var digits = digits
        for index in stride(from: digits.count - 1, through: 0, by: -1) {
            let result = digits[index] + 1
            if result > 9 {
                digits[index] = 0
                if index == 0 {
                    digits.insert(1, at: 0)
                }
            } else {
                digits[index] = result
                break
            }
        }
        return digits
    }
    
    /*
     有效的数独
     [
       ["5","3",".",".","7",".",".",".","."],
       ["6",".",".","1","9","5",".",".","."],
       [".","9","8",".",".",".",".","6","."],
       ["8",".",".",".","6",".",".",".","3"],
       ["4",".",".","8",".","3",".",".","1"],   -> true
       ["7",".",".",".","2",".",".",".","6"],
       [".","6",".",".",".",".","2","8","."],
       [".",".",".","4","1","9",".",".","5"],
       [".",".",".",".","8",".",".","7","9"]
     ]
     */
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var row: [[Int : Int]] = Array(repeating: [:], count: 9)
        var column: [[Int : Int]] = Array(repeating: [:], count: 9)
        var box: [[Int : Int]] = Array(repeating: [:], count: 9)
    
        for i in 0..<9 {
            for j in 0..<9 {
                let ch = board[i][j]
                if ch != "." {
                    let n = Int(String(ch))!
                    let box_index = (i / 3) * 3 + j / 3
                
                    if let _ = row[i][n] {
                        return false
                    } else {
                        row[i][n] = 1
                    }
                
                    if let _ = column[j][n] {
                        return false
                    } else {
                        column[j][n] = 1
                    }
                
                    if let _ = box[box_index][n] {
                        return false
                    } else {
                        box[box_index][n] = 1
                    }
                }
            }
        }

        return true
    }
}
