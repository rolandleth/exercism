//
//  PigLatin.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct PigLatin {
	
	static func translate(_ input: String) -> String {
		guard input.characters.count > 0 else { return "" }
		
		return input.components(separatedBy: " ").map {
			var output = $0
			let vowels: [Character] = ["a", "e", "i", "o", "u", "y"]
			let suffix = "ay"
			
			while (!vowels.contains(output.characters.first!) || output.hasPrefix("ye"))
				&& !output.hasPrefix("xr") {
					if output.hasPrefix("qu") {
						output = Array(output.characters
							.dropFirst()
							.dropFirst()).map { c -> String in
								return "\(c)"
							}
							.joined()
						output += "qu"
						
						continue
					}
					output = (output.characters.dropFirst() + [output.characters.removeFirst()])
						.map { "\($0)" }.joined()
			}
			
			return output + suffix
		}.joined(separator: " ")
	}
	
}
