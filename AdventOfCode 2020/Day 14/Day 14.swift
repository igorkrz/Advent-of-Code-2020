//
//  Day 14.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 17/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day14
{
    var array: [String]
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPart(part: Part)
    {
        var mask = [(offset: Int, element: String.Element)]()
        var memory = [String]()
        var result = [Int : Int]()
        
        array.enumerated().forEach({ operation in
            switch BitType(rawValue: String(operation.element.prefix(3))) {
            case .mas:
                switch part {
                case .One:
                    mask = operation.element
                    .components(separatedBy: CharacterSet(charactersIn: "="))
                    .last!
                    .trimmingCharacters(in: .whitespaces)
                    .reversed()
                    .enumerated()
                    .filter({ $0.element == "1" || $0.element == "0"})
                    
                case .Two:
                    mask = operation.element
                    .components(separatedBy: CharacterSet(charactersIn: "="))
                    .last!
                    .trimmingCharacters(in: .whitespaces)
                    .reversed()
                    .enumerated()
                    .filter({ $0.element == "1" || $0.element == "0" || $0.element == "X"})
                }
                
            case .mem:
                memory = operation.element
                    .components(separatedBy: CharacterSet(charactersIn: "[]="))
                    .filter({ $0 != "mem" && $0 != " "})
                    .map({ $0.trimmingCharacters(in: .whitespaces)})
                
                let address = Int(memory[0])!
                let value = Int(memory[1])!
                
                switch part {
                case .One:
                    result[address] = convertTo36Bit(value: value, mask: mask)
                case .Two:
                    result = convertAllTo36Bit(value: value, address: address, mask: mask, result: result)
                }
                
            case .none:
                fatalError()
            }
        })
        
        print(result.values.reduce(0, +))
    }
    
    private func convertTo36Bit(value: Int, mask: [(offset: Int, element: String.Element)]) -> Int?
    {
        let bitValue = String(value, radix: 2)
            .pad(with: "0", toLength: 36)
            .mask(with: mask)
            .convertToInteger()
        
        return bitValue
    }
    
    private func convertAllTo36Bit(value: Int, address: Int, mask: [(offset: Int, element: String.Element)], result: [Int : Int]) -> [Int : Int]
    {
        var result = result
        let bitValue = String(address, radix: 2)
            .pad(with: "0", toLength: 36)
            .mask(with: mask)
        
        let xValues = bitValue
            .enumerated()
            .filter({ $0.element == "X" })
            .map({$0.offset})
        
        let permutations = permutationsWithRepetitionFrom([0,1], taking: xValues.count)
        
        permutations.forEach({ perm in
            var newValue = bitValue
            perm.enumerated().forEach({ p in
                newValue = newValue.replace(at: xValues[p.offset], with: Character(String(p.element)))
            })
            let address = newValue.convertToInteger()!
            result[address] = value
        })
        
        return result
    }
    
    private func permutationsWithRepetitionFrom<T>(_ elements: [T], taking: Int) -> [[T]]
    {
      guard elements.count >= 0 && taking > 0 else { return [[]] }

      if taking == 1 {
        return elements.map {[$0]}
      }

      var permutations = [[T]]()
      for element in elements {
        permutations += permutationsWithRepetitionFrom(elements, taking: taking - 1).map {[element] + $0}
      }

      return permutations
    }
}

enum BitType: String
{
    typealias RawValue = String
    
    case mas
    case mem
}

extension String
{
    func pad(with character: String, toLength length: Int) -> String
    {
        let padCount = length - self.count
        guard padCount > 0 else { return self }

        return String(repeating: character, count: padCount) + self
    }
    
    func replace(at index: Int, with character: Character) -> String
    {
        var chars = Array(self)
        
        chars[index] = character
        
        return String(chars)
    }
    
    func mask(with mask: [(offset: Int, element: String.Element)]) -> String
    {
        var newString = self
        
        if mask.contains(where: {$0.element == "X"}) {
            mask.forEach({ bit in
                if bit.element != "0" {
                    newString = newString.replace(at: self.count - bit.offset - 1, with: bit.element)
                }
            })
        }
        else {
            mask.forEach({ bit in
                newString = newString.replace(at: self.count - bit.offset - 1, with: bit.element)
            })
        }
        
        return newString
    }
    
    func convertToInteger() -> Int?
    {
        if let int = Int(self, radix: 2) {
            return int
        }
        return nil
    }
}
