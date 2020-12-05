//
//  Day 5.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 05/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day5
{
    var array = [String]()
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne() -> Int
    {
        var numberOfSeats = 0
        for seat in array {
            if seat == "" {
                continue
            }
            let row = parseRow(seat: seat)
            let column = parseColumn(seat: seat)
            let seatId = calculateSeatId(row: row, column: column)
            
            if seatId > numberOfSeats {
                numberOfSeats = seatId
            }
        }
        
        return numberOfSeats
    }
    
    public func solutionPartTwo(numberOfSeats: Int)
    {
        var allSeats: [Int] = Array(0...numberOfSeats)
        for seat in array {
            if seat == "" {
                continue
            }
            let row = parseRow(seat: seat)
            let column = parseColumn(seat: seat)
            let seatId = calculateSeatId(row: row, column: column)
            
            // Set taken seats to value of -1
            
            allSeats[seatId] = -1
        }
        
        // Check if it is not the first seat and also check if the next and previous seat are taken
        
        if let result = allSeats.filter({$0 != 0 && allSeats[$0 + 1] == -1 && allSeats[$0 - 1] == -1}).first {
            print(result)
        }
        else {
            print("Some kind of error occured")
        }
    }
    
    private func parseRow(seat: String) -> Int
    {
        var min = 0
        var max = 127
        var startArray: [Int] = Array(min...max)
        var half = startArray.count / 2
        
        while startArray.count > 1 {
            for seatPart in seat {
                if seatPart == "B" {
                    min += half
                    startArray = Array(min...max)
                }
                else if seatPart == "F" {
                    max -= half
                    startArray = Array(min...max)
                }
                
                half = startArray.count / 2
            }
        }
        
        return startArray[0]
    }
    
    private func parseColumn(seat: String) -> Int
    {
        var min = 0
        var max = 7
        var startArray: [Int] = Array(min...max)
        var half = startArray.count / 2
        
        while startArray.count > 1 {
            for seatPart in seat {
                if seatPart == "R" {
                    min += half
                    startArray = Array(min...max)
                }
                else if seatPart == "L" {
                    max -= half
                    startArray = Array(min...max)
                }
                
                half = startArray.count / 2
            }
        }
        
        return startArray[0]
    }
    
    private func calculateSeatId(row: Int, column: Int) -> Int
    {
        return row * 8 + column
    }
}
