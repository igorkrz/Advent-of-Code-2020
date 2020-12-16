//
//  Day 11.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 14/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation


class Day11
{
    var array: [String]
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        let result = getAdjacentSeatsForLayout(array: array, part: 1)
        print(result.map { $0.reduce(0) { $0 + ($1 == "#" ? 1 : 0) } }.reduce(0, +))
    }
    
    public func solutionPartTwo()
    {
        let result = getAdjacentSeatsForLayout(array: array, part: 2)
        print(result.map { $0.reduce(0) { $0 + ($1 == "#" ? 1 : 0) } }.reduce(0, +))
    }
    
    private func getAdjacentSeatsForLayout(array: [String], part: Int) -> [String]
    {
        var adjacentSeats = [Character]()
        var result = String()
        let rowLength = array[0].count
        
        // Loop through every seat
        
        array.enumerated().forEach({ rowCounter, row in
            row.enumerated().forEach({ seatCounter, seat in
                
                // Append seats that are adjacent to the current seat
                
                let seatDirection = SeatDirection(rowNumber: rowCounter, seatNumber: seatCounter, rowLength: rowLength, part: part, array: array)
                
                // Left column
                
                if seatCounter == 0  {
                    
                    // Top left
                    
                    if rowCounter == 0 {
                        adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.right, .downRight, .down])
                    }
                        
                    // Bottom left
                    
                    else if rowCounter == array.count - 1 {
                        adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.up, .upRight, .right])
                    }
                        
                    // Middle left
                    
                    else {
                        adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.up, .upRight, .right, .downRight, .down])
                    }
                }
                    
                // Right column
                    
                else if seatCounter == rowLength - 1 {
                    
                    // Top right
                    
                    if rowCounter == 0 {
                        adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.down, .downLeft, .left])
                    }
                        
                    // Bottom right
                        
                    else if rowCounter == array.count - 1 {
                        adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.left, .upLeft, .up])
                    }
                        
                    // Middle right
                        
                    else {
                        adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.down, .downLeft, .left, .upLeft, .up])
                    }
                }
                    
                // Bottom row
                    
                else if rowCounter == array.count - 1 {
                    adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.up, .upRight, .right, .left, .upLeft])
                }
                    
                // Top row
                    
                else if rowCounter == 0 {
                    adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.right, .downRight, .down, .downLeft, .left])
                }
                
                // Middle
                    
                else {
                    adjacentSeats = seatDirection.returnAdjacentSeats(directions: [.up, .upRight, .right, .downRight, .down, .downLeft, .left, .upLeft])
                }
                
                // Determine if the seat is occupied
                
                result += String(seatOccupationManager(seat: seat, adjacentSeats: adjacentSeats, part: part))
                
                // Empty adjacentSeats
                
                adjacentSeats.removeAll()
            })
            
            // Append new line to result
            
            result += "\n"
        })
        
        // Transform result from String to [String]
        
        let splitResult = result.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: CharacterSet(charactersIn: "\n"))
        
        // Check if old result is the same as current result, otherwise call this function again on a new result
        
        return array == splitResult ? splitResult : getAdjacentSeatsForLayout(array: splitResult, part: part)
    }
    
    private func seatOccupationManager(seat: Character, adjacentSeats: [Character], part: Int) -> Character
    {
        let occupiedSeats = adjacentSeats.filter({ $0 == "#" }).count

        switch seat {
        case "L":
            if occupiedSeats == 0 {
                return "#"
            }

        case "#":
            switch part {
            case 1:
                if occupiedSeats >= 4 {
                    return "L"
                }
            case 2:
                if occupiedSeats >= 5 {
                    return "L"
                }
            default:
                break
            }
            
        case ".":
            break

        default:
            fatalError()
        }
        
        return seat
    }
}

enum Direction
{
    case up
    case upRight
    case right
    case downRight
    case down
    case downLeft
    case left
    case upLeft
}


struct SeatDirection
{
    var rowNumber: Int
    var seatNumber: Int
    var rowLength: Int
    var part: Int
    var array: [String]
    
    public func returnAdjacentSeats(directions: [Direction]) -> [Character]
    {
        switch part {
        case 1:
            return partOne(directions: directions)
        case 2:
            return partTwo(directions: directions)
        default:
            fatalError()
        }
    }
    
    private func partOne(directions: [Direction]) -> [Character]
    {
        let row = rowNumber
        let nextRow = rowNumber + 1
        let previousRow = rowNumber - 1
        let offset = seatNumber
        var adjacentSeats = [Character]()
        
        directions.forEach({ direction in
            switch direction {
            case .up:
                adjacentSeats.append(array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset)])
            case .upRight:
                adjacentSeats.append(array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset + 1)])
            case .right:
                adjacentSeats.append(array[row][array[row].index(array[row].startIndex, offsetBy: offset + 1)])
            case .downRight:
                adjacentSeats.append(array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset + 1)])
            case .down:
                adjacentSeats.append(array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset)])
            case .downLeft:
                adjacentSeats.append(array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset - 1)])
            case .left:
                adjacentSeats.append(array[row][array[row].index(array[row].startIndex, offsetBy: offset - 1)])
            case .upLeft:
                adjacentSeats.append(array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset - 1)])
            }
        })
        
        return adjacentSeats
    }
    
    private func partTwo(directions: [Direction]) -> [Character]
    {
        var adjacentSeats = [Character]()
        
        directions.forEach({ direction in
            adjacentSeats.append(partTwoEachDirection(direction: direction))
        })
        
        return adjacentSeats
    }
    
    private func partTwoEachDirection(direction: Direction) -> Character
    {
        let row = rowNumber
        var nextRow = rowNumber + 1
        var previousRow = rowNumber - 1
        var offset = seatNumber
        
        switch direction {
        case .up:
            while previousRow >= 1 {
                if array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset)] == "." {
                    previousRow -= 1
                }
                else {
                    return array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset)]
                }
            }
            return array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset)]
            
        case .upRight:
            while offset + 2 < rowLength && previousRow >= 1 {
                if array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset + 1)] == "." {
                    offset += 1
                    previousRow -= 1
                }
                else {
                    return array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset + 1)]
                }
            }
            return array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset + 1)]
            
        case .right:
            while offset + 2 < rowLength {
                if array[row][array[row].index(array[row].startIndex, offsetBy: offset + 1)] == "." {
                    offset += 1
                }
                else {
                    return array[row][array[row].index(array[row].startIndex, offsetBy: offset + 1)]
                }
            }
            return array[row][array[row].index(array[row].startIndex, offsetBy: offset + 1)]
            
        case .downRight:
            while offset + 2 < rowLength && nextRow < array.count - 1 {
                if array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset + 1)] == "." {
                    offset += 1
                    nextRow += 1
                }
                else {
                    return array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset + 1)]
                }
            }
            return array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset + 1)]
            
        case .down:
            while nextRow < array.count - 1 {
                if array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset)] == "." {
                    nextRow += 1
                }
                else {
                    return array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset)]
                }
            }
            return array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset)]
            
        case .downLeft:
            while offset > 1 && nextRow < array.count - 1 {
                if array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset - 1)] == "." {
                    offset -= 1
                    nextRow += 1
                }
                else {
                    return array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset - 1)]
                }
            }
            return array[nextRow][array[nextRow].index(array[nextRow].startIndex, offsetBy: offset - 1)]
            
        case .left:
            while offset > 1 {
                if array[row][array[row].index(array[row].startIndex, offsetBy: offset - 1)] == "." {
                    offset -= 1
                }
                else {
                    return array[row][array[row].index(array[row].startIndex, offsetBy: offset - 1)]
                }
            }
            return array[row][array[row].index(array[row].startIndex, offsetBy: offset - 1)]
            
        case .upLeft:
            while offset > 1 && previousRow >= 1 {
                if array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset - 1)] == "." {
                    offset -= 1
                    previousRow -= 1
                }
                else {
                    return array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset - 1)]
                }
            }
            return array[previousRow][array[previousRow].index(array[previousRow].startIndex, offsetBy: offset - 1)]
        }
    }
}
