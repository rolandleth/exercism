//
//  Scrabble.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Scrabble {
	
	private struct LetterGroup {
		
		var value: Int
		var letters: String
		
	}
	
	private let groups = [
		LetterGroup(value: 1, letters: "AEIOULNRST"),
		LetterGroup(value: 2, letters: "DG"),
		LetterGroup(value: 3, letters: "BCMP"),
		LetterGroup(value: 4, letters: "FHVWY"),
		LetterGroup(value: 5, letters: "K"),
		LetterGroup(value: 8, letters: "JX"),
		LetterGroup(value: 10, letters: "QZ")
	]
	
	private let word: String?
	
	var score: Int {
		guard let word = word, !word.isEmpty else { return 0 }
		
		return word.characters.reduce(0) { t, c in
			return t + (groups
				.filter { $0.letters.contains("\(c)".uppercased()) }
				.first?.value ?? 0
			)
		}
	}
	
	static func score(_ word: String) -> Int {
		return Scrabble(word).score
	}
	
	init(_ word: String?) {
		self.word = word
	}
	
}
