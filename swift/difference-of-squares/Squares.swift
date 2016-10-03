//
//  Squares.swift
//  helloWorld
//
//  Created by Roland Leth on 26.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Squares {
	
	let squareOfSums: Int
	let sumOfSquares: Int
	let differenceOfSquares: Int
	
	init(_ value: Int) {
		let range = (1...value)
		squareOfSums = Int(pow(Float(range.reduce(0, +)), 2))
		sumOfSquares = range.reduce(0) { $0 + Int(pow(Float($1), 2)) }
		differenceOfSquares = squareOfSums - sumOfSquares
	}
	
}
