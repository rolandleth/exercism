//
//  BeerSong.swift
//  helloWorld
//
//  Created by Roland Leth on 19.12.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct BeerSong {
	
	private let verses: String
	
	func generateVersesOfBeerSong() -> String {
		return verses
	}
	
	init(numberOfBeerBottles: Int) {
		func suffix(for bottles: Int) -> String {
			return bottles > 1 ? "s" : ""
		}
		
		verses = (0...numberOfBeerBottles).reversed().map {
			if $0 == 0 {
				return "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall."
			}
			
			var s = suffix(for: $0)
			let start = "\($0) bottle\(s) of beer on the wall, \($0) bottle\(s) of beer.\nTake one down and pass it around, "
			let end: String
			s = suffix(for: $0 - 1)
			
			if $0 > 1 {
				end = "\($0 - 1) bottle\(s) of beer on the wall."
			}
			else {
				end = "no more bottles of beer on the wall."
			}
			
			return "\(start)\(end)"
		}.joined(separator: "\n\n")
	}
	
}
