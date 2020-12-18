//
//  Day 15.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 17/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation


class Day15
{
    var array: [Int]
    
    init(array: [Int])
    {
        self.array = array
    }
    
    public func solutionPart(part: Part)
    {
        var nthNumber = 0
        var result = [Int : Int]()
        var turnCounter = 1
        
        switch part {
        case .One:
            nthNumber = 2020
        case .Two:
            nthNumber = 30000000
        }
        
        array.enumerated().forEach({ turn, lastSpokenNumber in
            result[lastSpokenNumber] = turn + 1
            turnCounter += 1
        })
        
        var memory = Memory(id: 0, next: 0, turn: turnCounter)
        
        while memory.turn != nthNumber {
            memory.id = memory.next
            memory.turn = turnCounter
            
            if let lastSeen = result[memory.id] {
                memory.next = memory.turn - lastSeen
            }
            else {
                memory.next = 0
            }
            
            result[memory.id] = memory.turn
            turnCounter += 1
        }
        print(memory.id)
    }
}

struct Memory
{
    var id: Int = 0
    var next: Int = 0
    var turn: Int = 0
    
    init(id: Int, next: Int, turn: Int)
    {
        self.id = id
        self.next = next
        self.turn = turn
    }
}
