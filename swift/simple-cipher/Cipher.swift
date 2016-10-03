//
//  Cipher.swift
//  helloWorld
//
//  Created by Roland Leth on 24.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Cipher {
	
	private let unicodeStart: UInt8 = 97
	private let unicodeEnd: UInt8 = 122
	let key: String
	
	
	// MARK: - Encoding
	
	func encode(_ data: String, reverse: Bool = false) -> String {
		return data.characters.enumerated().map { i, c -> String in
			guard i < key.characters.count else { return "\(c)" }
			let char = "\(c)".utf8.first!
			let keyIndex = key.characters.index(key.startIndex, offsetBy: i)
			let delta = "\(key[keyIndex])".utf8.first! - unicodeStart
			let possibleNewChar: UInt8
			let newChar: UInt8
			
			if reverse {
				possibleNewChar = char - delta
				newChar = possibleNewChar < unicodeStart
					? possibleNewChar + unicodeEnd - unicodeStart + 1
					: possibleNewChar
			}
			else {
				possibleNewChar = char + delta
				newChar = possibleNewChar > unicodeEnd
					? possibleNewChar - unicodeEnd + unicodeStart - 1
					: possibleNewChar
			}
			
			return "\(Character(UnicodeScalar(newChar)))"
		}.joined()
	}
	
	// Here we are just "encoding" in the other direction:
	// instead of offsetting positively, we have to do it negatively.
	func decode(_ data: String) -> String {
		return encode(data, reverse: true)
	}
	
	
	// MARK: - Init

	init() {
		var key = ""
		
		while key.characters.count < 10 {
			let char = UInt32(unicodeStart) + arc4random() % 25
			key += "\(Character(UnicodeScalar(char)!))"
		}

		self.key = key
	}
	
	init?(key: String) {
		guard
			key.lowercased() == key,
			!key.isEmpty,
			key.rangeOfCharacter(from: .decimalDigits) == nil
		else { return nil }
		
		self.key = key
	}
	
}
