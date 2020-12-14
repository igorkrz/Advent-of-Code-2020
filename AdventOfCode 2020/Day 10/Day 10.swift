//
//  Day 10.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 13/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation


class Day10
{
    var array: [Int]
    
    init(array: [Int])
    {
        self.array = array
        
        if let max = array.max() {
            self.array.append(max + 3)
        }
    }
    
    public func solutionPartOne()
    {
        var currentAdapter = 0
        var count1JoltDiff = 0
        var count3JoltDiff = 0
        
        if let joltageAdapter = array.max() {
            while currentAdapter != joltageAdapter {
                if array.filter({ $0 == currentAdapter + 1}).count > 0 {
                    currentAdapter += 1
                    count1JoltDiff += array.filter({ $0 == currentAdapter}).count
                }
                else if array.filter({ $0 == currentAdapter + 2}).count > 0 {
                    currentAdapter += 2
                }
                else if array.filter({ $0 == currentAdapter + 3}).count > 0 {
                    currentAdapter += 3
                    count3JoltDiff += array.filter({ $0 == currentAdapter }).count
                }
            }
            
            let result = count1JoltDiff * count3JoltDiff
            print(result)
        }
    }
    
    public func solutionPartTwo()
    {
        var permutations = [0:1]
        
        for adapter in array.sorted() {
            var total = 0
            
            for i in 1...3 {
                total += permutations[adapter - i, default: 0]
            }
            
            permutations[adapter] = total
        }
        print(permutations[array.max()!]!)
    }
}
