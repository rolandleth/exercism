//
//  Acronym.swift
//  helloWorld
//
//  Created by roland on 06/10/2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension String {
	
	subscript (index: Int) -> Character {
		return self[characters.index(startIndex, offsetBy: index)]
	}
	
}

struct Acronym {
	
	static func abbreviate(_ phrase: String) -> String {
		if
			let abbreviated = phrase.components(separatedBy: ":").first,
			abbreviated != phrase {
			return abbreviated
		}
		
		func isUppercase(_ char: String) -> Bool {
			return char == char.uppercased()
				&& char.rangeOfCharacter(from: .letters) != nil
		}
		
		return phrase.characters.enumerated()
			.flatMap {
				let c = "\($1)"
				guard $0 == 0
					|| isUppercase(c)
					|| phrase[$0 - 1] == "-"
					|| phrase[$0 - 1] == " "
					else { return nil }
				
				return c.uppercased()
			}
			.joined(separator: "")
	}
	
}
