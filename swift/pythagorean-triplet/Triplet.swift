//
//  Triplet.swift
//  helloWorld
//
//  Created by Roland Leth on 12.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Triplet {
	
	let isPythagorean: Bool
	let product: Int
	let sum: Int
	
	static func Where(_ start: Int = 1, maxFactor: Int, sum: Int? = nil) -> [Triplet] {
		var output: [Triplet] = []
		
		(start...maxFactor).forEach { a in
			(min(maxFactor, a + 1)...maxFactor).forEach { b in
				(min(maxFactor, b + 1)...maxFactor).forEach { c in
					let t = Triplet(a, b, c)
					if t.isPythagorean && (sum == nil || t.sum == sum!) {
						output.append(t)
					}
				}
			}
		}
		
		return output
	}
	
	init(_ a: Int, _ b: Int, _ c: Int) {
		isPythagorean = a * a + b * b == c * c
		product = a * b * c
		sum = a + b + c
	}
	
}
