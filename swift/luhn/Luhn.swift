//
//  Luhn.swift
//  helloWorld
//
//  Created by Roland Leth on 07.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Luhn {
	
	let addends: [Int]
	let checksum: Int
	let isValid: Bool
	
	static func create(_ input: Int) -> Int {
		let newValue = (0...9).map { String($0) }.filter {
			let nv = Int(String(input) + String($0))!
			return Luhn(nv).isValid
		}.first!
		
		return Int(String(input) + String(newValue))!
	}

	init(_ input: Int) {
		let s = String(input)
		addends = s.characters.flatMap { Int(String($0)) }.reversed().enumerated().map {
			var v = $1 * 2
			
			if $0 % 2 == 0 {
				v = $1
			}
			else if v > 10 {
				v -= 9
			}
			
			return v
		}.reversed()
		checksum = addends.reduce(0, +)
		isValid = checksum % 10 == 0
	}
	
}
