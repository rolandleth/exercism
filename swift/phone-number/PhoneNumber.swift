//
//  PhoneNumber.swift
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

struct PhoneNumber: CustomStringConvertible {
	
	let number: String
	var areaCode: String { return number[0..<3] }
	
	var description: String {
		return "(" + number[0..<3] + ") " + number[3..<6] + "-" + number[6..<10]
	}
	
	init(_ number: String) {
		let n = number
			.components(separatedBy: CharacterSet.alphanumerics.inverted)
			.filter { !$0.isEmpty }
			.joined(separator: "")
		
		guard
			n.characters.count == 10 || (n.characters.count == 11 && n[0..<1] == "1")
		else {
			self.number = "0000000000"
			return
		}
		
		if n.characters.count == 11 {
			self.number = n[1..<number.characters.count]
		}
		else {
			self.number = n
		}
	}
	
}
