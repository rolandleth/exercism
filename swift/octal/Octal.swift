//
//  Octal.swift
//  helloWorld
//
//  Created by Roland Leth on 07.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

extension Int {
	
	init(_ octal: Octal) {
		self = octal.integerValue
	}
	
}

struct Octal {
	
	let integerValue: Int
	
	init(_ input: String) {
		guard
			input.characters.flatMap({ Int("\($0)") }).filter({ $0 < 8 }).count == input.characters.count
		else { integerValue = 0; return }
		
		var int = 0
		for (i, c) in input.characters.reversed().enumerated() where Int("\(c)")! > 0 {
			int += Int(String(c))! * Int(pow(8, Float(i)))
		}
		integerValue = int
	}
	
}
