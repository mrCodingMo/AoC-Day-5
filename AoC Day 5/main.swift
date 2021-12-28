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

for _ in 0 ... 999 {
    
    var field = [Int](repeating: 0, count: 999)
    playGround.append(field)
}

var overlapingCount = 0
let overlapingSpecification = 2
for cor in coordinates {
    DrawLine(coordinate: cor, OnlyWhenIdentical: true)
}

printPlayground()
print(overlapingCount)

func DrawLine(coordinate : coordinate, OnlyWhenIdentical: Bool) {
    
    if OnlyWhenIdentical && !(coordinate.xIsIdentical() || coordinate.yIsIdentical()) { return }
    
    for y in coordinate.yFrom ... coordinate.yTo {
        
        for x in coordinate.xFrom ... coordinate.xTo {
     
            playGround[y][x] += 1
            if (playGround[y][x] >= overlapingSpecification) {
                overlapingCount += 1
            }
        }
    }
}



func printPlayground() {
    print("##############")
    for row in playGround {
        var line = ""
        for clm in row {
            if (clm == 0) {
                line.append(".")
            }else {
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
