//
//  Day 2.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 02/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day2
{
    var array = [String]()
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        var counter = 0
        var letterCounter = 0
        var password = Password()
        
        for line in array {
            if line == "" {
                continue
            }
            
            if counter % 2 == 0 {
                password = password.setPassword(line: line)
            }
            else {
                for letter in line {
                    if String(letter) == password.letter {
                        letterCounter += 1
                    }
                }
            }
            
            if password.isValidPartOne(letterCounter: letterCounter) {
                password.validPasswords += 1
            }
            
            letterCounter = 0
            counter += 1
        }
        print(password.validPasswords)
    }
    
    public func solutionPartTwo()
    {
        var password = Password()
        var counter = 0
        
        for line in array {
            if line == "" {
                continue
            }
            if counter % 2 == 0 {
                password = password.setPassword(line: line)
            }
            else {
                if password.isValidPartTwo(line: line) {
                    password.validPasswords += 1
                }
            }
            counter += 1
        }
        print(password.validPasswords)
    }
}

struct Password
{
    var lowerBound = Int.init()
    var upperBound = Int.init()
    var letter = String.init()
    var validPasswords = Int.init()
    
    public mutating func setPassword(line: String) -> Password
    {
        let conditions = line.split(separator: " ")
        let rangeElements = conditions[0].split(separator: "-")
        
        self.letter = String(conditions[1])
        self.lowerBound = Int(rangeElements[0])!
        self.upperBound = Int(rangeElements[1])!
        
        return self
    }
    
    public func isValidPartOne(letterCounter: Int) -> Bool
    {
        return letterCounter >= self.lowerBound && letterCounter <= self.upperBound
    }
    
    public func isValidPartTwo(line: String) -> Bool
    {
        let firstCondition = String(line[line.index(line.startIndex, offsetBy: self.lowerBound)]) == self.letter
        let secondCondition = String(line[line.index(line.startIndex, offsetBy: self.upperBound)]) == self.letter
        let validCondition = (firstCondition && !secondCondition) || (!firstCondition && secondCondition)
        
        return validCondition
    }
}
