//
//  Day 1.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 01/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day1
{
    var array: [Int]
    
    init(array: [Int])
    {
        self.array = array
    }
    
    func solutionPartOne()
    {
        for element in array {
            for otherElement in array {
                if element + otherElement == 2020 {
                    print(element * otherElement)
                    return
                }
            }
        }
    }

    func solutionPartTwo()
    {
        for element in array {
            for secondElement in array {
                for thirdElement in array {
                    if element + secondElement + thirdElement == 2020 {
                        print(element * secondElement * thirdElement)
                        return
                    }
                }
            }
        }
    }
}
