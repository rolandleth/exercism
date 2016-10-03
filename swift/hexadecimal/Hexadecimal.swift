//
//  Hexadecimal.swift
//  helloWorld
//
//  Created by Roland Leth on 02.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Hexadecimal {
	
	fileprivate var digits: [String]
	
	init(_ hex: String) {
		self.digits = hex.characters.map { "\($0)" }
	}
	
}

extension Int {
	
	private static let mapping = [
		"a": 10, "b": 11, "c": 12, "d": 13, "e": 14, "f": 15
	]
	private static let validDigits = Array(Int.mapping.keys) + (0...9).map { "\($0)" }
	
	init?(_ hex: Hexadecimal) {
		guard !hex.digits.contains(where: { !Int.validDigits.contains($0) }) else { return nil }

		self = hex.digits.reversed().enumerated().reduce(0) { t, e in
			let v = Int(e.1) ?? Int.mapping[e.1]!
			return t + v * Int(pow(16, Double(e.0)))
		}
	}
	
}
