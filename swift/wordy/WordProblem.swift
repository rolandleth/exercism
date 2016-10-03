//
//  WordProblem.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct WordProblem {
	
	enum PhraseError: Error {
		case irrelevant
		case tooComplex
	}
	
	private let result: Int
	func answer() -> Int {
		return result
	}
	
	init(_ phrase: String) throws {
		guard phrase.hasPrefix("What is") else { throw PhraseError.irrelevant }
		
		// Regex ftw :|
		var input = phrase.replacingOccurrences(of: "What is ", with: "")
		input = input.replacingOccurrences(of: "?", with: "")
		input = input.replacingOccurrences(of: "to the", with: "")
		input = input.replacingOccurrences(of: "power", with: "")
		
		let words = input.components(separatedBy: " ").filter { $0 != "by" && !$0.isEmpty }
		var operation = ""
		
		let operations = ["minus", "plus", "divided", "multiplied", "raised"]
		let sum = try words.reduce(0) { t, c in
			var n = c.replacingOccurrences(of: "st", with: "")
			n = n.replacingOccurrences(of: "nd", with: "")
			n = n.replacingOccurrences(of: "rd", with: "")
			n = n.replacingOccurrences(of: "th", with: "")
			
			guard let number = Int(n) else {
				if !operations.contains(c) {
					throw PhraseError.tooComplex
				}
				
				operation = c
				return t
			}
			
			switch operations.index(of: operation) {
			case 0?: return t - number
			case 2?: return t / number
			case 3?: return t * number
			case 4?: return Int(pow(Double(t), Double(number)))
			default: return t + number
			}
		}
		
		result = sum
	}
	
}
