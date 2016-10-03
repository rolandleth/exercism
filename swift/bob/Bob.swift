//
//  Bob.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Bob {
	
	static func hey(_ input: String) -> String {
		if input.replacingOccurrences(of: " ", with: "").isEmpty {
			return "Fine, be that way."
		}
		
		let containsLetters = input.utf16.contains {
			CharacterSet.letters.contains(UnicodeScalar($0)!)
		}
		
		if input == input.uppercased()
			&& !input.hasSuffix(".")
			&& containsLetters {
			return "Woah, chill out!"
		}
		
		if input.hasSuffix("?") {
			return "Sure."
		}
		
		return "Whatever."
	}
	
}
