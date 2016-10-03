//
//  PalindromeProducts.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension Int {
	
	func isPalindrome() -> Bool {
		let product = "\(self)"
		let reversed = product.characters.reversed().map { "\($0)" }.joined()
		return product == reversed
	}
	
}

struct PalindromeProducts {
	
	typealias Product = (value: Int, factor: Set<Int>)
	let smallest: Product
	let largest: Product
	
	init(maxFactor: Int, minFactor: Int = 1) {
		var smallest: Product = (0, [])
		var largest: Product = (0, [])
		
		// If we don't split into two iterations, we can't iterate backwards, or stop early.
		
		for f1 in (minFactor...maxFactor) {
			for f2 in (f1...maxFactor) {
				let p = f1 * f2
				// If the product is bigger than our current smallest palindrome, stop inner,
				// because it will just get bigger, since we increase the factors.
				guard p < smallest.value || smallest.value == 0 else { break }
				guard p.isPalindrome() else { continue }
				smallest = (p, [f1, f2])
			}
		}
		
		for f1 in (minFactor...maxFactor).reversed() {
			for f2 in (minFactor...f1).reversed() {
				let p = f1 * f2
				// If the product is smaller than our current largest palindrome, stop inner,
				// because it will just get smaller, since we decrease the factors.
				guard p > largest.value else { break }
				guard p.isPalindrome() else { continue }
				largest = (p, [f1, f2])
			}
		}
		
		self.smallest = smallest
		self.largest = largest
	}
	
}
