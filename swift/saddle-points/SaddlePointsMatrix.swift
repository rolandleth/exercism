//
//  SaddlePointsMatrix.swift
//  helloWorld
//
//  Created by Roland Leth on 20.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct SaddlePointsMatrix {
	
	let rows: [[Int]]
	let columns: [[Int]]
	let saddlePoints: [[Int]]
	
	init(_ diagram: String) {
		let rows = diagram
			.components(separatedBy: "\n")
			.map {
				$0.trimmingCharacters(in: .whitespaces)
					.components(separatedBy: " ").flatMap { Int($0) }
		}
		self.rows = rows
		
		let columns = rows.reduce([]) { columns, row -> [[Int]] in
			guard !columns.isEmpty else { return row.map { [$0] } }
			
			return columns.enumerated().map {
				guard $0 < row.count else { return $1 }
				return $1 + [row[$0]]
			}
		}
		self.columns = columns
		
		saddlePoints = rows.enumerated()
			.map { ri, row -> [Int] in
				[ri, row.index(of: row.max()!)!]
			}
			.filter {
				let column = columns[$0[1]]
				return column[$0[0]] == column.min()
		}
	}
	
}
