//
//  Matrix.swift
//  helloWorld
//
//  Created by Roland Leth on 10.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Matrix {
	
	let rows: [[Int]]
	let columns: [[Int]]
	
	init(_ diagram: String) {
		rows = diagram
			.components(separatedBy: "\n")
			.map {
				$0.trimmingCharacters(in: .whitespaces)
					.components(separatedBy: " ").flatMap { Int($0) }
			}
		
		columns = rows.reduce([]) { result, row -> [[Int]] in
			guard !result.isEmpty else { return row.map { [$0] } }
			
			return result.enumerated().map {
				guard $0 < row.count else { return $1 }
				return $1 + [row[$0]]
			}
		}
	}
	
}
