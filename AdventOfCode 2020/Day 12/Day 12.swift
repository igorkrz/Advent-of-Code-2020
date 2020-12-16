//
//  Day 12.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 16/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation


class Day12
{
    var array: [String]
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        let shipDistance = ShipDistance()
        array.forEach({ instruction in
            let startIndex = instruction.index(instruction.startIndex, offsetBy: 1)
            let endIndex = instruction.endIndex
            let direction = String(instruction.first!)
            let distance = Int(instruction[startIndex..<endIndex])
            
            switch ShipDirection(rawValue: direction)! {
            case .N:
                shipDistance.north += distance!
            case .E:
                shipDistance.east += distance!
            case .S:
                shipDistance.south += distance!
            case .W:
                shipDistance.west += distance!
            case .L:
                switch ShipLeftRotation(rawValue: instruction) {
                case .L90:
                    switch ShipCurrentDirection(rawValue: shipDistance.currentDirection) {
                        case .N:
                            shipDistance.currentDirection = "W"
                        case .E:
                            shipDistance.currentDirection = "N"
                        case .S:
                            shipDistance.currentDirection = "E"
                        case .W:
                            shipDistance.currentDirection = "S"
                        case .none:
                            fatalError()
                    }
                case .L180:
                    switch ShipCurrentDirection(rawValue: shipDistance.currentDirection) {
                        case .N:
                            shipDistance.currentDirection = "S"
                        case .E:
                            shipDistance.currentDirection = "W"
                        case .S:
                            shipDistance.currentDirection = "N"
                        case .W:
                            shipDistance.currentDirection = "E"
                        case .none:
                            fatalError()
                    }
                case .L270:
                    switch ShipCurrentDirection(rawValue: shipDistance.currentDirection) {
                        case .N:
                            shipDistance.currentDirection = "E"
                        case .E:
                            shipDistance.currentDirection = "S"
                        case .S:
                            shipDistance.currentDirection = "W"
                        case .W:
                            shipDistance.currentDirection = "N"
                        case .none:
                            fatalError()
                    }
                case .none:
                    fatalError()
                }
            case .R:
                switch ShipRightRotation(rawValue: instruction) {
                case .R90:
                    switch ShipCurrentDirection(rawValue: shipDistance.currentDirection) {
                        case .N:
                            shipDistance.currentDirection = "E"
                        case .E:
                            shipDistance.currentDirection = "S"
                        case .S:
                            shipDistance.currentDirection = "W"
                        case .W:
                            shipDistance.currentDirection = "N"
                        case .none:
                            fatalError()
                    }
                case .R180:
                    switch ShipCurrentDirection(rawValue: shipDistance.currentDirection) {
                        case .N:
                            shipDistance.currentDirection = "S"
                        case .E:
                            shipDistance.currentDirection = "W"
                        case .S:
                            shipDistance.currentDirection = "N"
                        case .W:
                            shipDistance.currentDirection = "E"
                        case .none:
                            fatalError()
                    }
                case .R270:
                    switch ShipCurrentDirection(rawValue: shipDistance.currentDirection) {
                        case .N:
                            shipDistance.currentDirection = "W"
                        case .E:
                            shipDistance.currentDirection = "N"
                        case .S:
                            shipDistance.currentDirection = "E"
                        case .W:
                            shipDistance.currentDirection = "S"
                        case .none:
                            fatalError()
                    }
                case .none:
                    fatalError()
                }
            case .F:
                switch ShipCurrentDirection(rawValue: shipDistance.currentDirection) {
                case .N:
                    shipDistance.north += distance!
                case .E:
                    shipDistance.east += distance!
                case .S:
                    shipDistance.south += distance!
                case .W:
                    shipDistance.west += distance!
                case .none:
                    fatalError()
                }
            }
        })
        
        print(shipDistance.manhattanDistance())
    }
    
    public func solutionPartTwo()
    {
        let shipDistance = ShipDistancePartTwo()
        
        array.forEach({ instruction in
            let startIndex = instruction.index(instruction.startIndex, offsetBy: 1)
            let endIndex = instruction.endIndex
            let direction = String(instruction.first!)
            let distance = Int(instruction[startIndex..<endIndex])
            
            switch ShipDirection(rawValue: direction)! {
            case .N:
                shipDistance.waypointNorth += distance!
            case .E:
                shipDistance.waypointEast += distance!
            case .S:
                shipDistance.waypointSouth += distance!
            case .W:
                shipDistance.waypointWest += distance!
            case .L:
                switch ShipLeftRotation(rawValue: instruction) {
                case .L90:
                    let north = shipDistance.waypointNorth
                    let east = shipDistance.waypointEast
                    let south = shipDistance.waypointSouth
                    let west = shipDistance.waypointWest
                    
                    shipDistance.waypointNorth = east
                    shipDistance.waypointEast = south
                    shipDistance.waypointSouth = west
                    shipDistance.waypointWest = north
                case .L180:
                    let north = shipDistance.waypointNorth
                    let east = shipDistance.waypointEast
                    
                    shipDistance.waypointNorth = shipDistance.waypointSouth
                    shipDistance.waypointEast = shipDistance.waypointWest
                    shipDistance.waypointSouth = north
                    shipDistance.waypointWest = east
                case .L270:
                    let north = shipDistance.waypointNorth
                    let east = shipDistance.waypointEast
                    let south = shipDistance.waypointSouth
                    let west = shipDistance.waypointWest
                    
                    shipDistance.waypointNorth = west
                    shipDistance.waypointEast = north
                    shipDistance.waypointSouth = east
                    shipDistance.waypointWest = south
                case .none:
                    fatalError()
                }
            case .R:
                switch ShipRightRotation(rawValue: instruction) {
                case .R90:
                    let north = shipDistance.waypointNorth
                    let east = shipDistance.waypointEast
                    let south = shipDistance.waypointSouth
                    let west = shipDistance.waypointWest
                    
                    shipDistance.waypointNorth = west
                    shipDistance.waypointEast = north
                    shipDistance.waypointSouth = east
                    shipDistance.waypointWest = south
                case .R180:
                    let north = shipDistance.waypointNorth
                    let east = shipDistance.waypointEast
                    
                    shipDistance.waypointNorth = shipDistance.waypointSouth
                    shipDistance.waypointEast = shipDistance.waypointWest
                    shipDistance.waypointSouth = north
                    shipDistance.waypointWest = east
                case .R270:
                    let north = shipDistance.waypointNorth
                    let east = shipDistance.waypointEast
                    let south = shipDistance.waypointSouth
                    let west = shipDistance.waypointWest
                    
                    shipDistance.waypointNorth = east
                    shipDistance.waypointEast = south
                    shipDistance.waypointSouth = west
                    shipDistance.waypointWest = north
                case .none:
                    fatalError()
                }
            case .F:
                shipDistance.north += shipDistance.waypointNorth * distance!
                shipDistance.east += shipDistance.waypointEast * distance!
                shipDistance.south += shipDistance.waypointSouth * distance!
                shipDistance.west += shipDistance.waypointWest * distance!
            }
        })
        print(shipDistance.manhattanDistance())
    }
}

enum ShipRightRotation: String
{
    typealias RawValue = String
    
    case R90
    case R180
    case R270
}

enum ShipLeftRotation: String
{
    typealias RawValue = String
    
    case L90
    case L180
    case L270
}

enum ShipCurrentDirection: String
{
    typealias RawValue = String
    
    case N
    case E
    case S
    case W
}

enum ShipDirection: String
{
    typealias RawValue = String
    
    case N
    case E
    case S
    case W
    case L
    case R
    case F
}

class ShipDistance
{
    var north = 0
    var east = 0
    var south = 0
    var west = 0
    var currentDirection = "E"
    
    public func manhattanDistance() -> Int
    {
        return abs(north - south) + abs(east - west)
    }
}

class ShipDistancePartTwo: ShipDistance
{
    var waypointNorth = 1
    var waypointEast = 10
    var waypointSouth = 0
    var waypointWest = 0
}
