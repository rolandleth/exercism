//
//  Board.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension Character {
	
	var isCorner: Bool { return self == "+" }
	var isFloor: Bool { return self == "-" }
	var isWall: Bool { return self == "|" }
	var isMargin: Bool { return isWall || isCorner || isFloor }
	var isMine: Bool { return self == "*" }
	var isValid: Bool { return self == " " || isMargin || isMine }
	
}

private extension String {
	
	subscript (index: Int) -> Character {
		return self[characters.index(startIndex, offsetBy: index)]
	}
	
}

struct Board {
	
	enum BoardError: Error {
		case faultyBorder
		case differentLength
		case invalidCharacter
	}
	
	private var diagram: [String]
	
	func transform() -> [String] {
		var output = diagram
		diagram.enumerated().forEach { rowi, row in
			guard (1..<diagram.count - 1) ~= rowi else { return }
			
			row.characters.enumerated().forEach { chari, char in
				guard (1..<row.characters.count - 1) ~= chari && !char.isMine else { return }
				
				let prev = output[rowi - 1]
				let row = output[rowi]
				let next = output[rowi + 1]
				var mines = 0
				
				[prev, row, next].forEach { r in
					[r[chari - 1], r[chari], r[chari + 1]].forEach { c in
						mines += (c.isMine ? 1 : 0)
					}
				}
				
				/* I think the above reads better than
				let mines = [prev, row, next].reduce(0) { t, r in
					t + [r[chari - 1], r[chari], r[chari + 1]].reduce(0) { t1, c in
						t1 + (c.isMine ? 1 : 0)
					}
				}
				*/
				
				let s = row.index(row.characters.startIndex, offsetBy: chari)
				let e = row.index(row.characters.startIndex, offsetBy: chari + 1)
				
				output[rowi] = row.replacingCharacters(in: s..<e, with: mines == 0 ? " " : "\(mines)")
			}
		}
		
		return output
	}
	
	init(_ input: [String]) throws {
		let length = input.first?.characters.count ?? 0
		
		for row in input {
			guard row.characters.count == length else { throw BoardError.differentLength }
			guard !row.characters.contains(where: { !$0.isValid }) else { throw BoardError.invalidCharacter }
			guard row.characters.first?.isCorner == true else {
				// If we don't start with a corner, we must start and end with a wall.
				guard
					row.characters.first?.isWall == true,
					row.characters.last?.isWall == true
					else { throw BoardError.faultyBorder }
				
				continue
			}
			
			// If we start with a corner, we must end with a corner.
			guard row.characters.last?.isCorner == true else { throw BoardError.faultyBorder }
			
			// And all intermediate characters have to be a floor("-").
			for (i, r) in row.characters.enumerated() {
				guard (1..<row.characters.count - 1) ~= i else { continue }
				guard r.isFloor else { throw BoardError.faultyBorder }
			}
		}
		
		diagram = input
	}
	
}
