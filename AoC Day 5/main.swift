import Foundation

func loadData() -> String{
    do {
        return try String(contentsOfFile: "/Users/moritzdiedenhofen/Documents/Daten/input.txt")
    } catch {
        return ""
    }
}

let data = loadData().split(separator: "\n")

let coordinates = data.map {coordinate(rawvalue: String($0))}

var playGround = [[Int]]()

for _ in 0 ... data.count - 1 {
    
    var field = [Int](repeating: 0, count: 10)
    playGround.append(field)
}

printPlayground()

for cor in coordinates {
    DrawLine(coordinate: cor, OnlyWhenIdentical: true)
}

printPlayground()

func DrawLine(coordinate : coordinate, OnlyWhenIdentical: Bool) {
    
    if OnlyWhenIdentical && !(coordinate.xIsIdentical() || coordinate.yIsIdentical()) { return }
    
    for x in coordinate.xFrom ... coordinate.xTo - 1 {
        for y in coordinate.yFrom ... coordinate.yTo - 1 {
            playGround[x][y] += 1
            printPlayground()
        }
                
    }
}

func printPlayground() {
    
    for row in playGround {
        var line = ""
        for clm in row {
            line.append(String(clm))
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
