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

// Solution day 8

let eighth: [String] = inputFile.readInput("Day 8", CharacterSet(charactersIn: "\n"))

let day8 = Day8(array: eighth)
day8.solutionPartOne()
day8.solutionPartTwo()

// Solution day 9

let ninth: [Int] = inputFile.readInput("Day 9", CharacterSet(charactersIn: "\n"))

let day9 = Day9(array: ninth)
if let solutionPartOne = day9.solutionPartOne() {
    print(solutionPartOne)
    day9.solutionPartTwo(solutionPartOne: solutionPartOne)
}

// Solution day 10

let tenth: [Int] = inputFile.readInput("Day 10", CharacterSet(charactersIn: "\n"))

let day10 = Day10(array: tenth)
day10.solutionPartOne()
day10.solutionPartTwo()

// Solution day 11

let eleventh: [String] = inputFile.readInput("Day 11", CharacterSet(charactersIn: "\n"))

let day11 = Day11(array: eleventh)
day11.solutionPartOne()
day11.solutionPartTwo()

// Solution day 12

let twelveth: [String] = inputFile.readInput("Day 12", CharacterSet(charactersIn: "\n"))

let day12 = Day12(array: twelveth)
day12.solutionPartOne()
day12.solutionPartTwo()

// Solution day 13
// TODO: Find better solution for part two

let thirteenth: [String] = inputFile.readInput("Day 13", CharacterSet(charactersIn: ",\n"))

let day13 = Day13(array: thirteenth)
day13.solutionPartOne()
day13.solutionPartTwo()
