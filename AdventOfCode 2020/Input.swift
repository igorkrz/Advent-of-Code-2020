//
//  Input.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 01/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation


class Input {
    
    enum InputType {
        case String
        case Int
    }
    
    func readInput(_ path: String, _ caseInput: InputType, _ separatedByCharacter: CharacterSet) -> Array<Any> {
        
        if let input = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
            let array : [String] = input.components(separatedBy: separatedByCharacter)
            switch caseInput {
            case .Int:
                let intArray : [Int] = array.compactMap { Int($0) }
                return intArray as [Int]
            case .String:
                return array as [String]
            }
        }
        print("Wrong input")
        return Array()
    }
    
    func splitArray(_ array: [String], _ separator: Character) -> [[String]]? {
        
        // Locate separator
        
        let indexArray = array.compactMap({$0.contains(separator)})
        
        // Split at first index of separator
        
        if let splitIndex = indexArray.firstIndex(of: true) {
            
            let endIndex = array.endIndex
            
            // Remove separator and add values
            
            let first = String(array[splitIndex].split(separator: separator)[0])
            let second = String(array[splitIndex].split(separator: separator)[1])
            var firstChunk = Array(array[0..<splitIndex])
            firstChunk.append(first)
            var secondChunk = Array(array[splitIndex..<endIndex])
            secondChunk[0] = second
            
            // Remove separator and add values
            
            if array[endIndex - 1].last == separator {
                let secondChunkEndIndex = secondChunk.endIndex
                let endItem = secondChunk[secondChunkEndIndex - 1].split(separator: separator).joined()
                secondChunk.removeLast()
                secondChunk.append(endItem)
            }
            return [firstChunk, secondChunk]
        }
        print("Split failed")
        return nil
    }
    
    func largeInput(_ path: String) -> String? {
        
        if let input = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
            return input
        }
        return nil
    }
}

