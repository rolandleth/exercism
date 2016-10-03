//
//  Base.swift
//  helloWorld
//
//  Created by Roland Leth on 10.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

enum BaseError: Error {
	case negativeDigit
	case invalidPositiveDigit
	case invalidInputBase
	case invalidOutputBase
}

struct Base {
	
	static func outputDigits(inputBase base: Double, inputDigits input: [Double], outputBase: Double) throws -> [Int] {
		guard outputBase > 1 else { throw BaseError.invalidOutputBase }
		guard base > 1 else { throw BaseError.invalidInputBase }
		
		try input.forEach {
			guard $0 >= 0 else { throw BaseError.negativeDigit }
			guard $0 < base else { throw BaseError.invalidPositiveDigit }
		}
		
		var value = input.reversed().enumerated().reduce(0) {
			$0 + $1.1 * pow(base, Double($1.0))
		}
		
		var exponent = floor(log(value) / log(outputBase))
		var output: [Int] = []
		
		while exponent >= 0 {
			let x = pow(outputBase, exponent)
			let digit = floor(value / x)
			output.append(Int(digit))
			
			value -= x * digit
			exponent -= 1
		}
		
		return output
	}
	
}
