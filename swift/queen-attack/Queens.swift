//
//  Queens.swift
//  helloWorld
//
//  Created by Roland Leth on 26.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Queens {
	
	enum InitError: Error {
		case sameSpace
		case invalidCoordinates
		case incorrectNumberOfCoordinates
	}
	
	private static let validRange = 0...7
	var description: String {
		return Queens.validRange.map { c -> String in
			return Queens.validRange.map { r -> String in
				switch (c, r) {
				case (white.first!, white.last!): return "W"
				case (black.first!, black.last!): return "B"
				default: return "_"
				}
			}.joined(separator: " ")
		}.joined(separator: "\n")
	}
	
	let white: [Int]
	let black: [Int]
	let canAttack: Bool
	
	init(white: [Int] = [0, 3], black: [Int] = [7, 3]) throws {
		guard white.count == 2, black.count == 2 else { throw InitError.incorrectNumberOfCoordinates }
		guard white != black else { throw InitError.sameSpace }
		
		guard
//			vr.contains(white.first!),
//			case vr = white.last!,
//			case vr = black.first!,
//			case vr = black.last!
			((white + black).filter { Queens.validRange.contains($0) }).count == 4
			else { throw InitError.invalidCoordinates }
		
		self.white = white
		self.black = black
		
		canAttack = { _ -> Bool in
			switch (white.first!, white.last!) {
			case (black.first!, _): return true
			case (_, black.last!): return true
			case _ where abs(black.first! - black.last!) == abs(white.first! - white.last!): return true
            case _ where abs(black.first! - white.first!) == abs(black.last! - white.last!): return true
			default: return false
			}
		}()
	}
	
}
