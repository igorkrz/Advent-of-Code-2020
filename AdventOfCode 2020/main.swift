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

let first: [Int] = inputFile.readInput("Day 1", CharacterSet(charactersIn: "\n"))

let day1 = Day1(array: first)
day1.solutionPartOne()
day1.solutionPartTwo()

// Solution day 2

let second: [String] = inputFile.readInput("Day 2", CharacterSet(charactersIn: ":\n"))

let day2 = Day2(array: second)
day2.solutionPartOne()
day2.solutionPartTwo()

// Solution day 3

let third: [String] = inputFile.readInput("Day 3", CharacterSet(charactersIn: "\n"))

let day3 = Day3(array: third)
day3.solutionPartOne()
day3.solutionPartTwo()

// Solution day 4

let fourth: [String] = inputFile.readInput("Day 4", CharacterSet(charactersIn: " \n"))
let day4 = Day4(array: fourth)
day4.solutionPartOne()
day4.solutionPartTwo()

// Solution day 5

let fifth: [String] = inputFile.readInput("Day 5", CharacterSet(charactersIn: "\n"))

let day5 = Day5(array: fifth)
let numberOfSeats = day5.solutionPartOne()
day5.solutionPartTwo(numberOfSeats: numberOfSeats)

// Solution day 6

let sixth: [String] = inputFile.readInput("Day 6", CharacterSet(charactersIn: "\n"))

let day6 = Day6(array: sixth)
day6.solutionPartOne()
day6.solutionPartTwo()

// Solution day 7

let seventh: [String] = inputFile.readInput("Day 7", CharacterSet(charactersIn: "\n"))

let day7 = Day7(array: seventh)
day7.solutionPartOne()
day7.solutionPartTwo()
