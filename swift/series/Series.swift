//
//  Series.swift
//  helloWorld
//
//  Created by roland on 05/10/2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Series {
	
	private let values: [Int]
	
	func slices(_ count: Int) -> [[Int]] {
		return values.enumerated().flatMap { (i, e) -> [Int]? in
			guard i <= values.count - count else { return nil }
			return (i..<i + count).map { values[$0] }
		}
	}
	
	init(_ input: String) {
		values = input.characters.flatMap { Int("\($0)") }
	}
	
}
