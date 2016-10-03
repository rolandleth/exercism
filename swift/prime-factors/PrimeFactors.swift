//
//  PrimeFactors.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct PrimeFactors {
	
	let toArray: [Int]
	
	init(_ number: Int) {
		var a: [Int] = []
		var i = 2
		var n = number
		
		while n > 1 {
			if n % i == 0 {
				a.append(i)
				n /= i
			}
			else {
				i += 1
			}
		}
		
		toArray = a
	}
	
}
