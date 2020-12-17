//
//  Day 13.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 16/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day13
{
    var array: [String]
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        let earliestTimestamp = Int(array.removeFirst())!
        var result = [Int : Int]()
        
        for bus in array.filter({ $0 != "x" }) {
            let busNumber = Int(bus)!
            let numberOfBuses = earliestTimestamp / busNumber
            let busTimestamp = busNumber * numberOfBuses + busNumber
            result[busNumber] = busTimestamp
        }
        
        let min = result.min(by: { (arg0, arg1) in
            let (_, nextValue) = arg1
            let (_, value) = arg0
            
            return value < nextValue
        })!
        
        print((result[min.key]! - earliestTimestamp) * min.key)
    }
    
    // MARK: Will not work for challenge input
    
    public func solutionPartTwo()
    {
        if array.count == 6 {
            array.removeFirst()
        }
        var buses = [Bus]()
        
        array.enumerated().forEach({ timestamp, bus in
            if bus != "x" {
                let bus = Bus(id: Int(bus)!, timestamp: timestamp)
                buses.append(bus)
            }
        })
        
        let max = buses.reduce(1, {$0 * $1.id})
        let bus1 = buses.remove(at: 0)
        var breakpoints = [Set<Int>]()
        buses.forEach({ bus in
            breakpoints.append(getBreakpoints(bus1: bus1, bus2: bus, max: max))
        })

        let result = breakpoints.reduce(breakpoints.first!) { a,b in
            a.intersection(b)
        }
        
        print(result.first!)
    }
    
    private func getBreakpoints(bus1: Bus, bus2: Bus, max: Int) -> Set<Int>
    {
        var resultCounter = 1
        var busCounter = 1
        var result = [Int]()
        
        while bus1.id * resultCounter <= max {
            let firstBusTimestamp = bus1.id * resultCounter
            while firstBusTimestamp + bus2.timestamp >= bus2.id * busCounter {
                if firstBusTimestamp + bus2.timestamp == bus2.id * busCounter {
                    result.append(bus1.id * resultCounter)
                }
                busCounter += 1
            }
            resultCounter += 1
        }
        
        return Set(result)
    }
}


class Bus
{
    var id: Int
    var timestamp: Int
    
    init(id: Int, timestamp: Int)
    {
        self.id = id
        self.timestamp = timestamp
    }
}
