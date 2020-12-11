//
//  Day 8.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 11/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day8
{
    var array: [String]
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        var accumulator = 0
        var seenInstructionIndexes = [0]
        var seenInstruction = Array<Substring>()
        var index = 0
        var condition = true
        
        while condition {
            seenInstruction = array[index].split(separator: " ")
            let instruction = String(seenInstruction[0])
            
            switch instruction {
            case "nop":
                index += 1
                condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                seenInstructionIndexes.append(index)
                
            case "acc":
                if let accValue = Int(seenInstruction[1]) {
                    accumulator += accValue
                    index += 1
                    condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                    seenInstructionIndexes.append(index)
                }
                else {
                    fatalError("Cannot unwrap acc")
                }
                
            case "jmp":
                if let jmpValue = Int(seenInstruction[1]) {
                    index += jmpValue
                    condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                    seenInstructionIndexes.append(index)
                }
                else {
                    fatalError("Cannot unwrap jmp")
                }
                
            default:
                fatalError()
            }
            
        }
        
        print(accumulator)
    }
    
    public func solutionPartTwo()
    {
        var accumulator = 0
        var seenInstructionIndexes = [0]
        var seenInstruction = Array<Substring>()
        var index = 0
        var condition = true
        
        while condition {
            seenInstruction = array[index].split(separator: " ")
            let instruction = String(seenInstruction[0])
            
            switch instruction {
            case "nop":
                if !seenInstruction[1].contains("0") {
                    array[index] = "jmp" + " " + seenInstruction[1]
                    condition = isEOF(accumulator: accumulator, seenInstructionIndexes: seenInstructionIndexes, seenInstruction: seenInstruction, index: index)
                    
                    if condition == true {
                        return
                    }
                    else {
                        array[index] = "nop" + " " + seenInstruction[1]
                    }
                }
                
                index += 1
                condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                seenInstructionIndexes.append(index)
                
            case "acc":
                if let accValue = Int(seenInstruction[1]) {
                    accumulator += accValue
                    index += 1
                    condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                    seenInstructionIndexes.append(index)
                }
                else {
                    fatalError("Cannot unwrap acc")
                }
                
            case "jmp":
                array[index] = "nop" + " " + seenInstruction[1]
                condition = isEOF(accumulator: accumulator, seenInstructionIndexes: seenInstructionIndexes, seenInstruction: seenInstruction, index: index)
                
                if condition == true {
                    return
                }
                else {
                    array[index] = "jmp" + " " + seenInstruction[1]
                }
                
                if let jmpValue = Int(seenInstruction[1]) {
                    index += jmpValue
                    condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                    seenInstructionIndexes.append(index)
                }
                else {
                    fatalError("Cannot unwrap jmp")
                }
                
            default:
                fatalError()
            }
            
        }
    }
    
    private func isExistingIndex(seenInstructionIndexes: [Int], index: Int) -> Bool
    {
        if seenInstructionIndexes.contains(index) && seenInstructionIndexes.count > 0 && index != 0 {
            return true
        }
        return false
    }
    
    private func isEOF(accumulator: Int, seenInstructionIndexes: [Int], seenInstruction: Array<Substring>, index: Int) -> Bool
    {
        var accumulator = accumulator
        var seenInstructionIndexes = seenInstructionIndexes
        var seenInstruction = seenInstruction
        var index = index
        var condition = true
        
        while condition {
            if seenInstructionIndexes.contains(array.count) {
                print(accumulator)
                return true
            }
            
            seenInstruction = array[index].split(separator: " ")
            let instruction = String(seenInstruction[0])
            
            switch instruction {
            case "nop":
                index += 1
                condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                seenInstructionIndexes.append(index)
                
            case "acc":
                if let accValue = Int(seenInstruction[1]) {
                    accumulator += accValue
                    index += 1
                    condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                    seenInstructionIndexes.append(index)
                }
                else {
                    fatalError("Cannot unwrap acc")
                }
                
            case "jmp":
                if let jmpValue = Int(seenInstruction[1]) {
                    index += jmpValue
                    condition = !isExistingIndex(seenInstructionIndexes: seenInstructionIndexes, index: index)
                    seenInstructionIndexes.append(index)
                }
                else {
                    fatalError("Cannot unwrap jmp")
                }
                
            default:
                fatalError()
            }
        }
        
        return condition
    }
}
