//
//  SumOfMultiples.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct SumOfMultiples {
	
	static func toLimit(_ limit: Int, inMultiples multiples: [Int]) -> Int {
		guard limit > 1 else { return 0 }
		
		let s1 = Date()
		var numbers: Set<Int> = []
		(1..<limit).forEach { i in
			multiples.forEach { m in
				guard i >= m && m > 0 else { return }
				
				if i % m == 0 {
					numbers.insert(i)
				}
			}
		}
		print(String(format: "%.10f", Date().timeIntervalSince(s1)))
		
		let s2 = Date()
		_ = (1..<limit).filter { i in
			for m in multiples where i >= m && m > 0 {
				if i % m == 0 { return true }
			}
			return false
		} // Just to try it out, but indeed it's much faster.
		print(String(format: "%.10f", Date().timeIntervalSince(s2)))
		
		return numbers.reduce(0, +)
	}
	
}
