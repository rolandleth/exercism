//
//  Transpose.swift
//  helloWorld
//
//  Created by Roland Leth on 19.12.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension String {
	
	subscript (index: Int) -> String {
		return "\(self[characters.index(startIndex, offsetBy: index)])"
	}
	
}

struct Transpose {

	static func transpose(_ input: [String]) -> [String] {
		let maxCount = input.reduce(0) { max($0, $1.characters.count) }
		var output: [String] = []
		
		input.forEach { w in
			(0..<maxCount).forEach { i in
				var letter = " "
				
				if i < w.characters.count {
					letter = w[i]
				}

				guard i < output.count else { return output.append(letter) }
				
				output[i] += letter
			}
		}
		
		output = output.map { o in
			var trimWhitespace = true
			
			return o.characters.reversed().map { c -> String in
				if c == " ", trimWhitespace { return "" }
				trimWhitespace = false
				return "\(c)"
			}.reversed().joined(separator: "")
		}
		
		return output
	}
	
}
