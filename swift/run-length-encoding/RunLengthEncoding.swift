//
//  RunLengthEncoding.swift
//  helloWorld
//
//  Created by Roland Leth on 29.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct RunLengthEncoding {
	
	static func encode(_ input: String) -> String {
		guard !input.isEmpty else { return "" }
		
		var count = 0
		var previous = input.characters.first!
		var new = ""
		
		input.characters.enumerated().forEach { i, c in
			if c == previous {
				count += 1
			}
			else {
				if count > 1 {
					new += "\(count)\(previous)"
				}
				else {
					new += "\(previous)"
				}
				
				count = 1
				previous = c
			}
			
			guard i == input.characters.count - 1 else { return }
			
			if count > 1 {
				return new += "\(count)\(previous)"
			}
			
			new += "\(previous)"
		}
		
		return new
	}
	
	static func decode(_ input: String) -> String {
		guard !input.isEmpty else { return "" }
		
		let repeats = input
			.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
			.map { Int($0) ?? 1 }
			.dropLast()
		let values = input
			.components(separatedBy: .decimalDigits)
			.flatMap { $0.characters.map { "\($0)" } }
		
		return repeats.enumerated().reduce("") { t, e -> String in
			guard e.offset < values.count else { return t }
			return t + String(repeating: values[e.offset], count: e.element)
		}
	}
	
}
