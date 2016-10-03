//
//  Sieve.swift
//  helloWorld
//
//  Created by Roland Leth on 07.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Sieve {
	
	let primes: [Int]
	
	init(_ number: Int) {
		func sieve(_ numbers: [Int], accumulator: [Int] = []) -> [Int] {
			guard !numbers.isEmpty else { return accumulator }
			
			var numbers = numbers
			let n = numbers.removeFirst()
			
			return sieve(numbers.filter { $0 % n != 0 }, accumulator: accumulator + [n])
		}
		
		primes = sieve(Array((2..<number)))
	}
	
}
