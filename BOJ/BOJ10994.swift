// BOJ 10994 별 찍기 - 19

let input = Int(readLine()!)!
let size = 1 + (input - 1) * 4

var map = Array(repeating: Array(repeating: " ", count: size), count: size)

func recur(_ depth: Int, _ size: Int) {
    if depth == 0 { return }
    
    // top = 시작 위치, 끝 위치를 계산해주기 위한 변수
    let top = (depth - 1) * 2
//    print(depth, top, size)
    for i in top..<size - top {
        map[top][i] = "*"
        map[size - top - 1][i] = "*"
    }
    for i in top..<size - top {
        map[i][top] = "*"
        map[i][size - top - 1] = "*"
    }
//    map.forEach { print($0) }
    recur(depth - 1, size)
}

recur(input, size)
map.forEach { print($0.joined()) }
