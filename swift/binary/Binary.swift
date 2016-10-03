//
//  Binary.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

extension Int {
	
	init(_ binary: Binary?) {
		self = binary?.integerValue ?? 0
	}
	
}

struct Binary {
	
	let integerValue: Int
	
	init?(_ binary: String) {
		guard
			binary.characters.filter({ "\($0)" == "1" || "\($0)" == "0" }).count == binary.characters.count
		else { return nil }
		
		var int = 0
		for (i, c) in binary.characters.reversed().enumerated() where Int("\(c)") == 1 {
			int += Int(pow(2, Float(i)))
		}
		integerValue = int
	}
	
}
