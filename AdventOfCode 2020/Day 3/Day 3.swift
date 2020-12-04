//
//  Day 3.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 02/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day3
{
    var array = [String]()
    private var lineLength = 0
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        let step = Step(right: 3, down: 1)
        var point = setPoint(inputPoint: nil, step: step)
        
        while point.lineCounter != array.count - 1 {
            point.rowCounter = point.rowCounter % lineLength
            point = setPoint(inputPoint: point, step: step)
        }
        print(point.result)
    }
    
    public func solutionPartTwo()
    {
        let steps = [Step(right: 1, down: 1), Step(right: 3, down: 1), Step(right: 5, down: 1), Step(right: 7, down: 1), Step(right: 1, down: 2)]
        var result = 1
        
        for step in steps {
            var point = setPoint(inputPoint: nil, step: step)
            
            while point.lineCounter != array.count - 1 {
                point.rowCounter = point.rowCounter % lineLength
                point = setPoint(inputPoint: point, step: step)
            }
            result *= point.result
        }
        print(result)
    }
    
    private func setPoint(inputPoint: Point?, step: Step) -> Point
    {
        if let point = inputPoint {
            return loopThroughInput(point: point, step: step)
        }
        else {
            let point = Point(rowCounter: 0, lineCounter: 0, result: 0)
            return loopThroughInput(point: point, step: step)
            
        }
    }
    
    private func loopThroughInput(point: Point, step: Step) -> Point
    {
        let counter = 1
        lineLength = array[0].count
        
        for line in array[point.lineCounter ..< array.count] {
            if line == "" {
                continue
            }
            
            if point.rowCounter >= lineLength {
                return point
            }
            
            if (point.lineCounter > 0 && (point.lineCounter % step.down == 0)) {
                if line[line.index(line.startIndex, offsetBy: point.rowCounter)] == "#" {
                    point.result += counter
                }
            }
            
            if point.lineCounter % step.down == 0 {
                point.rowCounter += step.right
            }
            
            point.lineCounter += counter
        }
        
        return point
    }
}

class Point
{
    var rowCounter: Int
    var lineCounter: Int
    var result: Int
    
    init(rowCounter: Int, lineCounter:Int, result: Int)
    {
        self.rowCounter = rowCounter
        self.lineCounter = lineCounter
        self.result = result
    }
}

class Step
{
    var right: Int
    var down: Int
    
    init(right: Int, down: Int)
    {
        self.right = right
        self.down = down
    }
}
