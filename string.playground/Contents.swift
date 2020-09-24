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
}
