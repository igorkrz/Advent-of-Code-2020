//
//  main.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 01/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

// Constant

let inputFile = Input()


// Solution day 1
 
let first = inputFile.readInput("Your path to file", .Int, CharacterSet(charactersIn: "\n"))

let day1 = Day1(array: first as! [Int])
day1.solutionPartOne()
day1.solutionPartTwo()

// Solution day 2
 
let second = inputFile.readInput("Your path to file", .String, CharacterSet(charactersIn: ":\n"))

let day2 = Day2(array: second as! [String])
day2.solutionPartOne()
day2.solutionPartTwo()

// Solution day 3
 
let third = inputFile.readInput("Your path to file", .String, CharacterSet(charactersIn: "\n"))

let day3 = Day3(array: third as! [String])
day3.solutionPartOne()
day3.solutionPartTwo()

// Solution day 4
 
let fourth = inputFile.readInput("Your path to file", .String, CharacterSet(charactersIn: " \n"))
let day4 = Day4(array: fourth as! [String])
day4.solutionPartOne()
day4.solutionPartTwo()


