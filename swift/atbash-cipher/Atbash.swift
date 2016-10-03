//
//  Atbash.swift
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

struct Atbash {
	
	static let original = "abcdefghijklmnopqrstuvwxyz".characters.map { "\($0)" }
	static let cipher: [String] = Atbash.original.reversed()
	
	static func encode(_ input: String) -> String {
		var output = ""
		let s = input.components(separatedBy: CharacterSet.alphanumerics.inverted)
			.filter { !$0.isEmpty }
			.joined(separator: "").lowercased()
		
		for (_, c) in s.characters.enumerated() {
			let letters = output.replacingOccurrences(of: " ", with: "")
			if !output.isEmpty && letters.characters.count % 5 == 0 {
				output += " "
			}
			
			let isNumber = CharacterSet.decimalDigits.contains(UnicodeScalar("\(c)".utf16.first!)!)
			if isNumber {
				output += "\(c)"
			}
			else {
				output += cipher[original.index(of: "\(c)")!]
			}
		}
		
		return output
	}
	
}
