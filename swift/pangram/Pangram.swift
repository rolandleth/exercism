//
//  Pangram.swift
//  helloWorld
//
//  Created by Roland Leth on 19.12.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Pangram {
	
	static func isPangram(_ input: String) -> Bool {
		var letters = "abcdefghijklmnopqrstuvwxyz".characters.map { "\($0)" }
		
		for letter in input.characters.map({ "\($0)" }) {
			guard let index = letters.index(of: letter.lowercased()) else { continue }
			letters.remove(at: index)
		}
		
		return letters.isEmpty
	}
	
}
