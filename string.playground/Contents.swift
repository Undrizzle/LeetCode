import UIKit

class Solution {
    /*
     反转字符串
     ["h","e","l","l","o"] -> ["o","l","l","e","h"]
     */
    func reverseString(_ s: inout [Character]) {
        var i = -1
        for ch in s.reversed() {
            i += 1
            s[i] = ch
        }
    }
    
    /*
     字符串中的第一个唯一字符
     "leetcode" -> 0
     */
    func firstUniqChar(_ s: String) -> Int {
        var dict = [String.Element: Int]()
        for ch in s {
            dict[ch, default: 0] += 1
        }
        for (idx, c) in s.enumerated() {
            if dict[c] == 1 {
                return idx
            }
        }
        return -1
    }
}
