//
//  BinarySearch.swift
//  helloWorld
//
//  Created by roland on 04/10/2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

enum BinarySearchError: Error {
	case unsorted
}

fileprivate extension Int {
	
	var half: Int {
		return Int(ceil(Double(self) * 0.5)) - 1
	}
	
}

struct BinarySearch {
	
	let middle: Int
	let list: [Int]
	
	func searchFor(_ value: Int) -> Int? {
		func index(for value: Int, in list: [Int], indices: [Int]) -> Int? {
			guard list.count > 1 else { return nil }
			let middle = list.count.half
			if value == list[middle] { return indices[middle] } // A guard felt forced.
			
			let newListRange: CountableRange<Int>
			if value < list[middle] {
				newListRange = 0..<middle
			}
			else {
				newListRange = middle..<list.count
			}
			
			return index(for: value, in: newListRange.map { list[$0] }, indices: newListRange.map { indices[$0] })
		}
		
		return index(for: value, in: list, indices: Array(0..<list.count))
	}
	
	init(_ data: [Int]) throws {
		var maxValue = 0
		try data.forEach {
			guard maxValue < $0 else { throw BinarySearchError.unsorted }
			maxValue = max(maxValue, $0)
		}
		
		list = data
		middle = data.count.half
	}
	
}
