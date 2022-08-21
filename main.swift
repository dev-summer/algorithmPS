let input = readLine()!.split(separator: " ").map { Int($0)! }
let r = input[0]
let c = input[1]
var start: (x: Int, y: Int) = (0, 0)
var end: (x: Int, y: Int) = (0, 0)

var map = Array(repeating: [Character](), count: r)
var visited = Array(repeating: Array(repeating: false, count: c), count: r)

for i in 0..<r {
    let line = Array(readLine()!)
    for j in 0..<c {
        if line[j] == "M" { start = (i, j) }
    }
    map[i].append(contentsOf: line)
}

let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

var queue = [(x: Int, y: Int)]()
var blank: (x: Int, y: Int) = (0, 0)
var idx = 0
var stop = false
func findNext(_ idx: Int) {
    let x = queue[idx].x
    let y = queue[idx].y
//    print("here", x, y)
    visited[x][y] = true
//    queue.removeFirst()
    
    let cur = map[x][y]
    switch cur {
    case ".":
        blank.x = x
        blank.y = y
        stop = true
    case "M":
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if nx < 0 || nx >= r || ny < 0 || ny >= c { continue }
            if map[nx][ny] == "." || map[nx][ny] == "Z" { continue }
            queue.append((nx, ny))
        }
    case "Z":
        stop = true
    case "-":
        if visited[x][y - 1] { queue.append((x, y + 1))}
        if visited[x][y + 1] { queue.append((x, y - 1))}
    case "|":
        if visited[x - 1][y] { queue.append((x + 1, y))}
        if visited[x + 1][y] { queue.append((x - 1, y))}
    case "1":
        if visited[x][y + 1] { queue.append((x + 1, y))}
        if visited[x + 1][y] { queue.append((x, y + 1))}
    case "2":
        if visited[x - 1][y] { queue.append((x, y + 1))}
        if visited[x][y + 1] { queue.append((x - 1, y))}
    case "3":
        if visited[x - 1][y] { queue.append((x, y - 1))}
        if visited[x][y - 1] { queue.append((x - 1, y))}
    case "4":
        if visited[x][y - 1] { queue.append((x + 1, y))}
        if visited[x + 1][y] { queue.append((x, y - 1))}
    case "+":
        var adjBlank = [(x: Int, y: Int)]()
        var adjFilled = [(x: Int, y: Int)]()
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if visited[nx][ny] { continue }
            if map[nx][ny] == "." {
                adjBlank.append((nx, ny))
            } else {
                adjFilled.append((nx, ny))
            }
        }
        
        if adjBlank.isEmpty {
            queue.append(contentsOf: adjFilled)
        } else {
            queue.append(contentsOf: adjBlank)
        }
    default:
        return
    }
}

func fillBlank(_ x: Int, _ y: Int) -> Character {
    var hasUp = false
    var hasDown = false
    var hasLeft = false
    var hasRight = false
        
    if x - 1 >= 0 {
        let point = map[x - 1][y]
        if point == "|" || point == "+" || point == "1" || point == "4" {
            hasUp = true
        }
    }
    
    if x + 1 < r {
        let point = map[x + 1][y]
        if point == "|" || point == "+" || point == "2" || point == "3" {
            hasDown = true
        }
    }
    
    if y - 1 >= 0 {
        let point = map[x][y - 1]
        if point == "-" || point == "+" || point == "1" || point == "2" {
            hasLeft = true
        }
    }
    
    if y + 1 < c {
        let point = map[x][y + 1]
        if point == "-" || point == "+" || point == "3" || point == "4" {
            hasRight = true
        }
    }
    
    if hasUp {
        if hasDown {
            if hasLeft && hasRight { return "+" }
            else { return "|" }
        } else {
            if hasLeft { return "3" }
            else { return "2" }
        }
    } else {
        if !hasDown { return "-" }
        else {
            if hasLeft { return "4" }
            else { return "1" }
        }
    }
}

func sol() {
    var result = [Character]()
    queue.append((start.x, start.y))
    
    while !stop {
        findNext(idx)
        idx += 1
//        print(stop, idx)
    }
    
//    print(blank)
    result.append(Character(String(blank.x + 1)))
    result.append(Character(String(blank.y + 1)))
    let char = fillBlank(blank.x, blank.y)
    result.append(char)
    result.forEach{ print($0, terminator: " ") }
}

sol()
//import Foundation
//
//var distance = [Int]()
//var weakPoint = [Int]()
//var length = 0
//var wall = [Int]()
//
//
//// 시계방향, 반시계방향 모두 고려해야 함
//func findMax(_ friend: Int) {
//    var curSum = 0
//    var maxSum = 0
//    var maxInfo: (start: Int, sum: Int, dir: String) = (0, 0, "")
//    var start = 0
//
//    for end in 0..<length {
//        curSum += wall[end]
//
//        if curSum > maxSum {
//            maxSum = curSum
//            maxInfo = (start, maxSum, "clock")
//        }
//
//        if end >= friend {
//            curSum -= wall[start]
//            start += 1
//        }
//    }
//
//    curSum = 0
//    start = length - 1
//    var count = 0
//    // end가 0까지 가면 안됨! start가 0까지 가야함
//    for end in stride(from: length - 1, through: -friend + 1, by: -1) {
//        if end < 0 {
//            curSum += wall[end + length]
//        } else {
//            curSum += wall[end]
//        }
//        count += 1
//
//        if curSum > maxSum {
//            maxSum = curSum
//            maxInfo = (start, maxSum, "anti")
//        }
//
//        if count >= friend {
//            curSum -= wall[start]
//            start -= 1
//            count -= 1
//        }
//    }
//
//    print(maxInfo)
//    if maxInfo.dir == "clock" {
//        for i in maxInfo.start...maxInfo.start + friend {
//            if wall[i] == 1 {
//                wall[i] = 0
//            }
//        }
//    } else {
//        for i in maxInfo.start - friend...maxInfo.start {
//            print(maxInfo.start, friend)
//            print(i)
//            if wall[i] == 1 {
//                wall[i] = 0
//            }
//        }
//    }
//}
//
//
//func solution(_ n:Int, _ weak:[Int], _ dist:[Int]) -> Int {
//    distance = dist.sorted { $0 > $1 }
//    weakPoint = weak
//    length = n
//    wall = Array(repeating: 0, count: length)
//
//    for i in 0..<weakPoint.count {
//        wall[weakPoint[i]] += 1
//    }
//    print(wall)
//    var friends = 0
//    for friend in distance {
//        print(friend)
//        findMax(friend)
//        friends += 1
//        print(wall)
//        if !wall.contains(0) {
//            break
//        }
//    }
//
//    return friends
//}
//
//solution(12, [1, 5, 6, 10], [1, 2, 3, 4])

//import Foundation
//
//func timeToSec(_ time: String) -> Int {
//    var inSeconds = 0
//    let timeArr = time.split(separator: ":").map { Int($0)! }
//    inSeconds = timeArr[0] * 3600 + timeArr[1] * 60 + timeArr[2]
//
//    return inSeconds
//}
//
//var playTime = 0
//var advTime = 0
//var playArr = [Int]()
//var playSum = 0
//var answer = 0
//var answerTime = 0
//var curUser = -1
//var map = [(index: Int, users: Int)]()
//
//func fillMap() {
//    for i in 0...playTime {
//        if playArr[i] != curUser {
//            curUser = playArr[i]
//            map.append((index: i, users: curUser))
//        }
//    }
//}
//
//func calculate() -> Int {
//    var windowSum = 0
//    var maxSum = 0
//    var windowStart = 0
//
//    for windowEnd in 0...playTime {
//        windowSum += playArr[windowEnd]
//
//        if windowEnd >= advTime {
//            if windowSum > maxSum {
//                maxSum = windowSum
//                answerTime = windowStart
//            }
//            windowSum -= playArr[windowStart]
//            windowStart += 1
//        }
//    }
//
//    return maxSum
//}
//
//func secToTime(_ sec: Int) -> String {
//    var h = ""
//    var t = ""
//    var s = ""
//
//    if sec / 3600 >= 10 {
//        h = String(sec / 3600)
//    } else {
//        h = h + "0" + String(sec / 3600)
//    }
//
//    let remainder = sec % 3600
//    if remainder / 60 >= 10 {
//        t = String(remainder / 60)
//    } else {
//        t = t + "0" + String(remainder / 60)
//    }
//
//    if remainder % 60 >= 10 {
//        s = String(remainder % 60)
//    } else {
//        s = s + "0" + String(remainder % 60)
//    }
//
//    let time: String = h + ":" + t + ":" + s
//    return time
//}
//
//func solution(_ play_time:String, _ adv_time:String, _ logs:[String]) -> String {
//    playTime = timeToSec(play_time)
//    advTime = timeToSec(adv_time)
//    playArr = Array(repeating: 0, count: playTime + 1)
//
//    for user in logs {
//        let userArr = user.split(separator: "-").map { String($0) }
//        let userStart = timeToSec(userArr[0])
//        let userEnd = timeToSec(userArr[1])
//
//        for i in userStart...userEnd {
//            playArr[i] += 1
//        }
//    }
//
//    fillMap()
//    answer = calculate()
//    let result = secToTime(answerTime)
//
////    print(result)
//    return result
//}
//
//solution("02:03:55", "00:14:15", ["01:20:15-01:45:14", "00:40:31-01:00:00", "00:25:50-00:48:29", "01:30:59-01:53:29", "01:37:44-02:02:30"])
////
//print(playArr[timeToSec("01:30:59")])
//print(playArr[timeToSec("01:45:14")])
//print(playArr[timeToSec("01:51:59")])
