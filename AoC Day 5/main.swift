import Foundation

func loadData() -> String{
    do {
        return try String(contentsOfFile: "/Users/moritzdiedenhofen/Documents/Daten/input.txt")
    } catch {
        return ""
    }
}

let coordinates = loadData().split(separator: "\n").map {coordinate(rawvalue: String($0))}
var playGround = [[Int]]()
var playgroundSize = 1000

for _ in 0 ... playgroundSize {
    playGround.append([Int](repeating: 0, count: playgroundSize))
}

var overlapingCount = 0
let overlapingSpecification = 2

for cor in coordinates {
    DrawLine(coordinate: cor, OnlyWhenIdentical: true)
}

for i in 0 ... playgroundSize - 1{
    for ii in 0 ... playgroundSize - 1 {
        if playGround[i][ii] >= 2 {overlapingCount += 1}
    }
}

print(overlapingCount)

func DrawLine(coordinate : coordinate, OnlyWhenIdentical: Bool) {
    
    if OnlyWhenIdentical && !(coordinate.xIsIdentical() || coordinate.yIsIdentical()) { return }
    
    for y in coordinate.yFrom ... coordinate.yTo {
        for x in coordinate.xFrom ... coordinate.xTo {
            playGround[y][x] += 1
        }
    }
}



func printPlayground() {

    for row in playGround {
        var line = ""
        for clm in row {
            if (clm == 0) {
                line.append(".")
            } else {
                line.append(String(clm))
            }
            
        }
        print(line)
    }
    
}

struct coordinate {
    
    init(rawvalue: String) {
        
        let parts = rawvalue.replacingOccurrences(of: ">", with: "").split(separator: "-")
        
        let firstPart = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
        let secondPart = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
        
        xFrom = Int(firstPart.split(separator: Character(","))[0]) ?? 0
        xTo = Int(secondPart.split(separator: Character(","))[0]) ?? 0
        
        yFrom = Int(firstPart.split(separator: Character(","))[1]) ?? 0
        yTo = Int(secondPart.split(separator: Character(","))[1]) ?? 0
        
        if (xFrom > xTo){
            let x = xFrom
            xFrom = xTo
            xTo = x
        }
        
        if (yFrom > yTo){
            let y = yFrom
            yFrom = yTo
            yTo = y
        }
        
    }
    
    var xFrom = 0
    var xTo = 0
    
    var yFrom = 0
    var yTo = 0
    
    func xIsIdentical() -> Bool{
        return xFrom == xTo
    }
    
    func yIsIdentical() -> Bool{
        return yFrom == yTo
    }
    
}
