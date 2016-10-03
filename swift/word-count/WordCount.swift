//
//  WordCount.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct WordCount {
	
	private let words: [String: Int]
	
	func count() -> [String: Int] {
		return words
	}
	
	init(words string: String) {
		var words: [String: Int] = [:]
		
		let invalidCharacters = CharacterSet.alphanumerics.inverted
		for word in string
			.components(separatedBy: invalidCharacters)
			.filter({ !$0.isEmpty }) {
				let nw = word.lowercased()
				if let w = words[nw] {
					words[nw] = w + 1
				}
				else {
					words[nw] = 1
				}
		}
		
		self.words = words
	}
	
}
