//
//  Prime.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension Int {
	
	func isPrime() -> Bool {
		guard self % 2 != 0 else { return false }
		guard self % 3 != 0 else { return false }
		
		let root = Int(floor(sqrt(Double(self))))
		var current = 5
		
		while current <= root {
			if self % current == 0 { return false }
			// Primes can be written as 6n +/- 1, and since we start at 6n - 1,
			// we test 6n + 1 by adding 2 on each step.
			if self % (current + 2) == 0 { return false }
			current += 6
		}
		
		return true
	}
	
}

struct Prime {
	
	static func nth(_ th: Int) -> Int? {
		guard th > 0 else { return nil }
		guard th > 1 else { return 2 }
		
		var primes = [2, 3]
		var possible = 3
		
		// var found: Bool
		
		while primes.count < th {
			possible += 2
			// found = true
			// This is the fastest, at 0.015
			guard possible.isPrime() else { continue }
			
			// Even though this and the for loop do the same thing,
			// this takes 15 seconds, the for loop takes 0.75 :|
			// if primes.contains(where: { possible % $0 == 0 }) { continue }
			// for prime in primes {
			//	if possible % prime == 0 {
			//		found = false
			//		break
			//	}
			// }
			// guard found else { continue }
			primes.append(possible)
		}
		
		return primes.last!
	}
	
}
