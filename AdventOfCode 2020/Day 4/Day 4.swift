//
//  Day 4.swift
//  AdventOfCode 2020
//
//  Created by Igor Krznar on 04/12/2020.
//  Copyright © 2020 Igor Krznar. All rights reserved.
//

import Foundation

class Day4
{
    var array = [String]()
    
    init(array: [String])
    {
        self.array = array
    }
    
    public func solutionPartOne()
    {
        let splitArray = Array([array.split(separator: "")].joined())
        let passports = collectPassports(loopArray: splitArray)
        let result = checkPassportsPartOne(passports: passports)
        
        print(result)
    }
    
    public func solutionPartTwo()
    {
        let splitArray = Array([array.split(separator: "")].joined())
        let passports = collectPassports(loopArray: splitArray)
        let result = checkPassportsPartTwo(passports: passports)
        
        print(result)
    }
    
    enum Info: Substring
    {
        typealias RawValue = Substring
        
        case byr
        case iyr
        case eyr
        case hgt
        case hcl
        case ecl
        case pid
        case cid
    }

    private func collectPassports(loopArray: [ArraySlice<String>]) -> [Passport]
    {
        var passports = [Passport]()
        for passportInfo in loopArray {
            let passport = Passport(birthYear: 0, issueYear: 0, expirationYear: 0, height: "", hairColor: "", eyeColor: "", passportId: "", countryId: "")
            for info in passportInfo {
                let key = info[info.startIndex..<info.index(info.startIndex, offsetBy: 3)]
                let value = String(info[info.index(info.startIndex, offsetBy: 4)..<info.endIndex])

                switch Info(rawValue: key) {
                case .byr:
                    passport.birthYear = Int(value)!
                case .iyr:
                    passport.issueYear = Int(value)!
                case .eyr:
                    passport.expirationYear = Int(value)!
                case .hgt:
                    passport.height = value
                case .hcl:
                    passport.hairColor = value
                case .ecl:
                    passport.eyeColor = value
                case .pid:
                    passport.passportId = value
                case .cid:
                    passport.countryId = value
                default:
                    print("Error")
                }
            }
            passports.append(passport)
        }

        return passports
    }

    private func checkPassportsPartOne(passports: [Passport]) -> Int
    {
        var result = 0
        for passport in passports {
            let isValid = (passport.birthYear != 0 && passport.issueYear != 0 && passport.expirationYear != 0 && passport.height != "" && passport.hairColor != "" && passport.eyeColor != "" && passport.passportId != "")
            if isValid {
                result += 1
            }
        }
        
        return result
    }
    
    private func checkPassportsPartTwo(passports: [Passport]) -> Int
        {
            var result = 0
            for passport in passports {
                let isValidBirthYear = passport.birthYear! >= 1920 && passport.birthYear! <= 2002
                
                let isValidIssueYear = passport.issueYear! >= 2010 && passport.issueYear! <= 2020
                
                let isValidExpirationYear = passport.expirationYear! >= 2020 && passport.expirationYear! <= 2030
                
                var isValidHeight = false
                if passport.height!.contains("cm") && passport.height!.count == 5{
                    let validHeight = Int(passport.height![passport.height!.startIndex..<passport.height!.index(passport.height!.startIndex, offsetBy: 3)])
                    isValidHeight = validHeight! >= 150 && validHeight! <= 193
                }
                else if passport.height!.contains("in") && passport.height!.count == 4{
                    let validHeight = Int(passport.height![passport.height!.startIndex..<passport.height!.index(passport.height!.startIndex, offsetBy: 2)])
                    isValidHeight = validHeight! >= 59 && validHeight! <= 76
                }
                
                let validHairColors = CharacterSet(charactersIn: "abcdef")
                let validHairColorsNumber = CharacterSet(charactersIn: "0123456789")
                var isValidHairColor = false
                if let hairColor = passport.hairColor {
                    var newHairColor = hairColor
                    if newHairColor != "" {
                        if newHairColor.first! == "#" {
                            newHairColor.remove(at: hairColor.startIndex)
                            if newHairColor.rangeOfCharacter(from: validHairColorsNumber) != nil || newHairColor.rangeOfCharacter(from: validHairColors) != nil {
                                    isValidHairColor = true
                            }
                        }
                    }
                }
                
                let isValidEyeColor = passport.eyeColor! == "amb" || passport.eyeColor! == "blu" || passport.eyeColor! == "brn" || passport.eyeColor! == "gry" || passport.eyeColor! == "grn" || passport.eyeColor! == "hzl" || passport.eyeColor! == "oth"
                
                let isValidPassportId = passport.passportId!.count == 9 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: passport.passportId!))
                
                let isValid = isValidBirthYear && isValidIssueYear && isValidExpirationYear && isValidHeight && isValidHairColor  && isValidEyeColor && isValidPassportId
                if isValid {
                    result += 1
                }
            }
            
            return result
        }
}

class Passport
{
    var birthYear: Int?
    var issueYear: Int?
    var expirationYear: Int?
    var height: String?
    var hairColor: String?
    var eyeColor: String?
    var passportId: String?
    var countryId: String?
    
    init
    (
        birthYear: Int,
        issueYear: Int,
        expirationYear: Int,
        height: String,
        hairColor: String,
        eyeColor: String,
        passportId: String,
        countryId: String
    )
    {
        self.birthYear = birthYear
        self.issueYear = issueYear
        self.expirationYear = expirationYear
        self.height = height
        self.hairColor = hairColor
        self.eyeColor = eyeColor
        self.passportId = passportId
        self.countryId = countryId
    }
}
