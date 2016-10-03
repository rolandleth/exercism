//
//  Robot.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension String {
	
	subscript (range: Range<Int>) -> String {
		let start = characters.index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex)
		let end = characters.index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex)
		return self[start!..<end!]
	}
	
}

struct Robot {
	
	private static var lastName = "AA000"
	var name: String
	
	mutating func resetName() {
		let lastName = Robot.lastName
		let prefix = lastName[0..<2]
		let suffix = Int(lastName[2..<lastName.characters.count]) ?? 0
		var newSuffix = suffix == 999 ? "001" : "\(suffix + 1)"
		var newPrefix = prefix
		
		if newSuffix.characters.count == 1 {
			newSuffix = "00\(newSuffix)"
		}
		else if newSuffix.characters.count == 2 {
			newSuffix = "0\(newSuffix)"
		}
		
		defer {
			name = newPrefix + newSuffix
			Robot.lastName = name
		}
		
		guard suffix == 999 else { return }
		
		if prefix[1..<2] == "Z" {
			if prefix[0..<1] == "Z" {
				newPrefix = "AA"
			}
			else {
				newPrefix = String(
					describing: UnicodeScalar((prefix[0..<1].unicodeScalars.first!.value + UInt32(1)))
				) + "A"
			}
		}
		else {
			newPrefix = "A" + String(
				describing: UnicodeScalar((prefix[1..<2].unicodeScalars.first!.value + UInt32(1)))
			)
		}
	}
	
	init() {
		name = Robot.lastName
		resetName()
	}
	
}
