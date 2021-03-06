// BOJ 14889 스타트와 링크
// 축구를 모하기 위해 모인 사람 N명 (짝수, 4 <= N <= 20)
// 두 팀의 능력치의 차이가 최소화 되도록
// 능력치의 차이의 최솟값 출력

let size = Int(readLine()!)!

var map = Array(repeating: [Int](), count: size)
for i in 0..<size {
    map[i].append(contentsOf: readLine()!.split(separator: " ").map { Int($0)! })
}

var teamSize = size / 2
var players = Array(1...size)

func getSum(_ arr: [Int]) -> Int {
    var sum = 0
    for i in 0..<arr.count {
        for j in 0..<arr.count {
            let p1 = arr[i] - 1
            let p2 = arr[j] - 1
            sum += map[p1][p2]
            // 한 행마다 같은 팀인 경우를 더해주기 때문에, [i][j], [j][i]를 결과적으로는 모두 더하게 된다
        }
    }
    
    return sum
}

var start = [Int]()
var link = [Int]()
var minGap = Int.max

func recur(_ idx: Int) {
    if start.count == teamSize && link.count == teamSize && idx == size {
//        print(start)
//        print(link)
        let startSum = getSum(start)
        let linkSum = getSum(link)
        
        let gap = abs(startSum - linkSum)
        if gap < minGap {
            minGap = gap
        }
//        print("start: \(start)")
//        print("link: \(link)")
//        print(minGap)
    }
    
    if idx >= size { return }
    if start.count > teamSize || link.count > teamSize { return }
    
    start.append(players[idx])
    recur(idx + 1)
    1 2 3
    start.removeLast()
    1 2
//    print("remove")
    link.append(players[idx])
    1 2
    3
//    print("start: \(start), link: \(link)")
    recur(idx + 1)
    // start의 마지막 원소를 제거하기 전에 link를 비워야 한다
    1 2 3
    link.removeLast()
}

recur(0)
print(minGap)
