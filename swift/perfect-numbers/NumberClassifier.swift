//
//  NumberClassifier.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct NumberClassifier {
	
	enum Classification {
		case perfect
		case deficient
		case abundant
	}
	
	let number: Int
	
	var classification: Classification {
		let sum = (1...Int(number / 2)).reduce(0) { (sum, current) -> Int in
			guard number % current == 0 else { return sum + 0 }
			return sum + current
		}
		
		switch sum {
		case number: return .perfect
		case Int.min..<number: return .deficient
		default: return .abundant
		}
	}
	
}
