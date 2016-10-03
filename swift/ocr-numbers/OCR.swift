//
//  OCR.swift
//  helloWorld
//
//  Created by Roland Leth on 20.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension String {
	
	var isPipe: Bool { return self == "|" }
	var isLine: Bool { return self == "_" }
	var isSpace: Bool { return self == " " }
	
}

private extension Set {
	
	mutating func remove(_ elements: [Element]) {
		for e in elements {
			remove(e)
		}
	}
	
	mutating func keep(_ elements: [Element]) {
		for e in self where !elements.contains(e) {
			remove(e)
		}
	}
	
}

struct OCR {
	
	enum OCRError: Error {
		case invalidNumberOfLines
		case invalidNumberOfColumns
	}
	
	private let rows: [[String]]
	private let columns: [[String]]
	
	func converted() -> String {
		let numbers = Set((0..<10).map { "\($0)" })
		/**
		Here we keep possible results:
		A diagram of
		```
		1 2 3
		4 ? 6
		7 8 9
		```
		will start as an array of 3 arrays, of 3 sets each:
		```
		[
		  [[0...9], [0...9], [0...9]],
		  [[0...9], [0...9], [0...9]],
		  [[0...9], [0...9], [0...9]]
		]
		```
		We then remove from each set what doesn't match.
		At the end we should have a set with one element for each slot,
		or empty, if no number was found:
		```
		[
		  [[1], [2], [3]],
		  [[4], [ ], [6]],
		  [[7], [8], [9]]
		]
		```
		Extracting the first element, or `?` will result in:
		```
		[
		  [1, 2, 3],
		  [4, ?, 6],
		  [7, 8, 9]
		]
		```
		Joining them will result in:
		```
		[
		  123,
		  4?6,
		  789
		]
		```
		Finally, joining these with a comma separator will result in:
		```
		123,4?6,789
		```
		*/
		var results: [[Set<String>]] = (0..<rows.count / 4).map { _ in
			(0..<columns.count / 3).map { _ in numbers }
		}
		
		// Iterate through the numbers' rows.
		for r in stride(from: 0, to: rows.count, by: 4) {
			// Iterate through the numbers' columns.
			for c in stride(from: 0, to: columns.count, by: 3) {
				// The current line of the current row
				var l = r
				// The current numbers' characters.
				var first: String { return rows[l][c] }
				var second: String { return rows[l][c + 1] }
				var third: String { return rows[l][c + 2] }
				// The set of possible results for the current number.
				var possible = results[r / 4][c / 3]
				
				if first.isSpace && second.isSpace && third.isSpace {
					possible.keep(["1", "4"])
				}
				else {
					possible.remove(["1", "4"])
				}
				
				// Move to the next line.
				l += 1
				
				if first.isPipe && second.isSpace && third.isPipe {
					possible.keep(["0"])
				}
				else if first.isPipe && second.isLine && third.isPipe {
					possible.keep(["4", "8", "9"])
				}
				else if first.isSpace && second.isSpace && third.isPipe {
					possible.keep(["1", "7"])
				}
				else if first.isSpace && second.isLine && third.isPipe {
					possible.keep(["2", "3"])
				}
				else if first.isPipe && second.isLine && third.isSpace {
					possible.keep(["5", "6"])
				}
				else {
					possible.removeAll()
				}
				
				// Move to the last line.
				l += 1
				
				if first.isPipe && second.isLine && third.isSpace {
					possible.keep(["2"])
				}
				else if first.isSpace && second.isLine && third.isPipe {
					possible.keep(["3", "5", "9"])
				}
				else if first.isPipe && second.isLine && third.isPipe {
					possible.keep(["0", "8", "6"])
				}
				else if first.isSpace && second.isSpace && third.isPipe {
					possible.keep(["1", "4", "7"])
				}
				else {
					possible.removeAll()
				}
				
				// Save back our results.
				results[r / 4][c / 3] = possible
			}
		}
		
		return results
			.map { r in
				// The first of each set, joined into a number, for rows
				r.map { $0.first ?? "?" }.joined()
			}
			// Joined into a sequence, for columns
			.joined(separator: ",")
	}
	
	init(_ text: String) throws {
		rows = text.components(separatedBy: "\n").map { return $0.characters.map { "\($0)" } }
		columns = rows.reduce([]) { columns, row -> [[String]] in
			guard !columns.isEmpty else { return row.map { [$0] } }
			
			return columns.enumerated().map {
				guard $0 < row.count else { return $1 }
				return $1 + [row[$0]]
			}
		}
		
		guard rows.count % 4 == 0 else { throw OCRError.invalidNumberOfLines }
		guard columns.count % 3 == 0 else { throw OCRError.invalidNumberOfColumns }
	}
	
}
