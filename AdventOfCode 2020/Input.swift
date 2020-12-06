//
//  Input.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 01/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation


class Input
{
    public func readInput<T>(_ path: String, _ separatedByCharacter: CharacterSet) -> [T]
    {
        // let pathToFile = "/Users/somePath/\(path)/input.txt"
        
        let pathToFile = "Your path to file"
        
        do {
            let input = try String(contentsOfFile: pathToFile, encoding: String.Encoding.utf8)
            let array : [String] = input.components(separatedBy: separatedByCharacter)
            
            if T.self == Int.self {
                let intArray : [Int] = array.compactMap { Int($0) }
                return intArray as! [T]
            }
            else {
                var stringArray = array
                if stringArray.last == "" {
                    stringArray.removeLast()
                }
                return stringArray as! [T]
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func splitArray(_ array: [String], _ separator: Character) -> [[String]]?
    {
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
    
    public func largeInput(_ path: String) -> String?
    {
        do {
            let input = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            return input
        } catch {
            return error.localizedDescription
        }
    }
}

