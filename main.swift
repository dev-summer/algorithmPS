import Foundation

//class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        var arr = Array(repeating: 0, count: nums.count)
        
        arr[0] = nums[0]
        var max = nums[0]
        
        for i in 1..<nums.count {
            print(nums[i], i)
            arr[i] = nums[i] + (arr[i - 1] > 0 ? arr[i - 1] : 0)
            print(arr[i])
            max = max > arr[i] ? max : arr[i]
            print("max:", max)
        }
        
        print(max)
        return max
    }
//}

maxSubArray([5,4,-1,7,8])

