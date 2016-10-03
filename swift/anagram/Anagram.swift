//
//  Anagram.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Anagram {
	
	private let word: String
	
	func match(_ array: [String]) -> [String] {
		return array.filter {
			$0.lowercased() != word
				&& $0.lowercased().characters.sorted() == word.lowercased().characters.sorted()
		}
	}
	
	init(word: String) {
		self.word = word
	}
	
}
