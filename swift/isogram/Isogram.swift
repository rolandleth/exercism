//
//  Isogram.swift
//  helloWorld
//
//  Created by Roland Leth on 19.12.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Isogram {
	
	static func isIsogram(_ input: String) -> Bool {
		var letters: [String] = []
		let nonAlphanumerics = NSCharacterSet.alphanumerics.inverted
		
		for letter in input.characters.map({ "\($0)"}) {
			let l = letter.lowercased()
			
			guard
				!letters.contains(l)
				|| nonAlphanumerics.contains(l.unicodeScalars.first!)
			else { return false }
			
			letters.append(l)
		}
		
		return true
	}
	
}
