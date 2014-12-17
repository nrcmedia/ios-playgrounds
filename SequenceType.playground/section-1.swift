import UIKit

// Example of seperate structs implementing SequenceType and GeneratorType

struct Rainbow {
    let colors = [UIColor.redColor(),UIColor.orangeColor(),UIColor.yellowColor(),UIColor.greenColor(),UIColor.blueColor(),UIColor.purpleColor()]
}

struct RainbowGenerator : GeneratorType {
    typealias Element = UIColor
    var currentPosition: Int = 0
    let colors: [UIColor]
    init(colors: [UIColor]) {
        self.colors = colors
    }
    mutating func next() -> UIColor? {
        if currentPosition >= colors.count {
            return nil
        }
        let color = colors[currentPosition]
        currentPosition++
        return color
    }
}

extension Rainbow : SequenceType {
    func generate() -> RainbowGenerator {
        return RainbowGenerator(colors: colors)
    }
}

let r = Rainbow()

for color in r {
    let view = UIView(frame: CGRectMake(0, 0, 100, 25))
    view.backgroundColor = color
    view
}

// Example of using the GeneratorOf struct to iterate over an enum

enum Direction : String {
    case North = "N"
    case West = "W"
    case South = "S"
    case East = "E"
}

var nextDirection: Direction? = .North
let next: Void -> Direction? = {
    if nextDirection == nil {
        return nil
    }
    let currentDirection = nextDirection!
    switch currentDirection {
    case .North:
        nextDirection = .South
    case .South:
        nextDirection = .East
    case .East:
        nextDirection = .West
    case .West:
        nextDirection = nil
    }
    return currentDirection
}

let directions = GeneratorOf(next)

for d in directions {
    println(d.rawValue)
}
