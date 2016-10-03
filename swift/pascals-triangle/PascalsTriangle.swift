//
//  PascalsTriangle.swift
//  helloWorld
//
//  Created by Roland Leth on 20.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct PascalsTriangle {
	
	let rows: [[Int]]
	
	init(_ input: Int) {
		func computeNextRows(for triangle: [[Int]]) -> [[Int]] {
			guard triangle.count < input else { return triangle }
			
			let lastRow = triangle.last!
			let newRow = [lastRow.first!] + lastRow.enumerated().map { i, e -> Int in
				guard i < lastRow.count - 1 else { return e }
				return e + lastRow[i + 1]
			}
			
			return computeNextRows(for: triangle + [newRow])
		}

		rows = computeNextRows(for: [[1]])
	}
	
}
