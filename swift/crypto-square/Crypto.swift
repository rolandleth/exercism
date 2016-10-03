//
//  Crypto.swift
//  helloWorld
//
//  Created by Roland Leth on 07.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension String {
	
	subscript (index: Int) -> Character {
		return self[characters.index(startIndex, offsetBy: index)]
	}
	
}

struct Crypto {
	
	let size: Int
	let normalizePlaintext: String
	let plaintextSegments: [String]
	let ciphertext: String
	let normalizeCiphertext: String
	
	
	init(_ input: String) {
		let plainString = input.characters
			.map { String($0) }
			.filter { CharacterSet.alphanumerics.contains(UnicodeScalar($0.utf16.first!)!) }
			.joined(separator: "").lowercased()
		
		let rows = Int(sqrt(Float(plainString.characters.count)))
		let cols = rows * rows == plainString.characters.count ? rows : rows + 1
		
		func split(_ string: String, into size: Int) -> [String] {
			var a: [String] = []
			var e = ""
			
			for (i, c) in string.characters.map({ String($0) }).enumerated() {
				e += c
				
				if e.characters.count == size || i == string.characters.count - 1 {
					a.append(e)
					e = ""
				}
			}
			
			return a
		}
		
		let plainSegments = split(plainString, into: cols)
		size = cols
		normalizePlaintext = plainString
		plaintextSegments = plainSegments
		ciphertext = (0..<cols).flatMap { i -> [String] in
			plainSegments.flatMap { s -> String? in
				i >= s.characters.count ? nil : String(s[i])
			}
		}.joined(separator: "")
		normalizeCiphertext = split(ciphertext, into: rows).joined(separator: " ")
	}
	
}
