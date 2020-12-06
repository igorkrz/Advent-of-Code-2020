//
//  Day 6.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 06/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day6
{
    var array = [String]()
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        let splitArray = array.split(separator: "")
        var resultArray = [String]()
        
        for element in splitArray {
            var set = Set<Character>()
            let removedDuplicates = element.joined().filter{ set.insert($0).inserted }
            resultArray.append(removedDuplicates)
        }
        
        let result = resultArray.reduce(0) { $0 + $1.count }
        print(result)
    }
    
    public func solutionPartTwo()
    {
        let splitArray = array.split(separator: "")
        var result = 0
        for elements in splitArray {
            let allCharacters = elements.map({ Set($0) })
            let intersections = allCharacters.reduce(Set("abcdefghijklmnopqrstuvwxyz")) { a, b in
                a.intersection(b)
            }
            let intersectionsCount = intersections.count
            result += intersectionsCount
        }
        print(result)
    }
}
