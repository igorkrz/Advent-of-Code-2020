//
//  Day 9.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 11/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day9
{
    var array: [Int]
    
    init(array: [Int])
    {
        self.array = array
    }
    
    public func solutionPartOne() -> Int?
    {
        var lowerRange = 0
        var upperRange = 25
        var numberToSearchFor = 0
        var counter = 0
        while upperRange < array.count {
            if counter >= 4 {
                numberToSearchFor = array[upperRange]
                let preamble = array[lowerRange..<upperRange]
                if let result = getValidNumber(preamble: preamble, numberToSearchFor: numberToSearchFor) {
                    return result
                }
                lowerRange += 1
                upperRange += 1
            }
            counter += 1
        }
        return nil
    }
    
    public func solutionPartTwo(solutionPartOne: Int?)
    {
        if let invalidNumber = solutionPartOne {
            if let result = calculateResultForContiguousSet(numberToSearchFor: invalidNumber) {
                print(result)
            }
        }
        else {
            fatalError()
        }
    }
    
    private func getValidNumber(preamble: ArraySlice<Int>, numberToSearchFor: Int) -> Int?
    {
        var result = false
        preamble.forEach({ element in
            if result == true {
                return
            }
            preamble.forEach({ otherElement in
                if element + otherElement == numberToSearchFor && element != otherElement {
                    result = true
                    return
                }
            })
        })
        
        if result == false {
            return numberToSearchFor
        }
        
        return nil
    }
    
    private func calculateResultForContiguousSet(numberToSearchFor: Int) -> Int?
    {
        var sum = 0
        var upperRange = 0
        var lowerRange = 0
        var preamble = ArraySlice<Int>()
        
        while sum != numberToSearchFor {
            while sum < numberToSearchFor {
                sum += array[upperRange]
                upperRange += 1
            }
            
            
            while sum > numberToSearchFor {
                lowerRange += 1
                preamble = array[lowerRange..<upperRange]
                sum = preamble.reduce(0, +)
            }
        }
        
        if let min = preamble.min() {
            if let max = preamble.max() {
                return min + max
            }
        }
        
        return nil
    }
}
