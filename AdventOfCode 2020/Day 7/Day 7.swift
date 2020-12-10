//
//  Day 7.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 07/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day7
{
    var array = [String]()
    var result = 0
    var seenColors = [String]()
    var bags = [String : [String : Int]]()
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        let colorToSearchFor = ["shiny gold"]
        
        // Recursive function to search for all the parent bags of the current bag/bags
        
        let _ = bagsToFind(colorToSearchFor: colorToSearchFor)
        
        print(result)
    }
    
    public func solutionPartTwo()
    {
        let colorToSearchFor = ["shiny gold"]
        
        // Recursive function to search for all the parent bags of the current bag/bags
        
        let _ = bagsToFind2(colorToSearchFor: colorToSearchFor)
        
        print(result)
    }
    
    private func bagsToFind(colorToSearchFor: [String]) -> [String]
    {
        guard colorToSearchFor.count != 0 else {
            return colorToSearchFor
        }
        
        var resultArray = [String]()
        
        for bag in colorToSearchFor {
            
            for line in array {
                
                if line.contains(bag) {
                    
                    let splittedComponents = line.split(separator: " ")
                    let bagColor = String(splittedComponents[0] + " " + splittedComponents[1])
                    
                    if bagColor != bag && !seenColors.contains(bagColor) {
                        
                        resultArray.append(bagColor)
                        seenColors.append(bagColor)
                    }
                }
            }
        }
        
        result += resultArray.count
        
        return bagsToFind(colorToSearchFor: resultArray)
    }
    
    private func bagsToFind2(colorToSearchFor: [String]) -> [String]
    {
        guard colorToSearchFor.count != 0 else {
            
            result = countBags(bag: "shiny gold")

            return colorToSearchFor
        }

        var resultArray = [String]()

        for bag in colorToSearchFor {
            for line in array {
                if line.contains(bag) {
                    let splittedComponents = line.split(separator: " ")
                    let bagColor = String(splittedComponents[0] + " " + splittedComponents[1])

                    if bagColor == bag {
                        if let index = splittedComponents.firstIndex(of: "contain") {
                            if splittedComponents[index + 1] != "no" {
                                var name = ""
                                var number = 0
                                var children = [String: Int]()

                                for counter in stride(from: 1, to: splittedComponents.count - index, by: 4) {
                                    number = Int(String(splittedComponents[index + counter]))!
                                    name = String(splittedComponents[index + counter + 1] + " " + splittedComponents[index + counter + 2])
                                    children[name] = number

                                    resultArray.append(String(name))
                                    bags[bag] = children
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return bagsToFind2(colorToSearchFor: resultArray)
    }
   
    func countBags(bag: String) -> Int
    {
        var count = 0

        if let found = bags[bag] {
            for bag in found {
                let value = bag.value
                count += value
                let cnt = value * countBags(bag: bag.key)
                count += cnt
            }
        }
        return count
    }
}
