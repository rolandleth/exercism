//
//  BracketPush.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension Character {
	
	var counterpart: Character {
		switch self {
		case "}": return "{"
		case ")": return "("
		default: return "["
		}
	}
	
}

struct BracketPush {
	
	static func paired(text: String) -> Bool {
		var opened: [Character] = []
		var properlyNested = true
		
		text.characters.forEach {
			if ["[", "(", "{"].contains($0) {
				opened.append($0)
			}
			
			guard ["]", ")", "}"].contains($0) else { return }
			
			if opened.last == $0.counterpart {
				opened.removeLast()
			}
			else {
				properlyNested = false
			}
		}
		
		return opened.isEmpty && properlyNested
	}
	
}
