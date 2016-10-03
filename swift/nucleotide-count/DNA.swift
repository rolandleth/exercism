//
//  DNA.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct DNA {
	
	private let strand: String
	
	func count(_ element: String) -> Int {
		return strand.characters.filter { String($0) == element }.count
	}
	
	func counts() -> [String: Int] {
		var elementsCount = ["T": 0, "A": 0, "C": 0, "G": 0]
		
		strand.characters.forEach {
			elementsCount[String($0)]! += 1
		}
		
		return elementsCount
	}
	
	init?(strand: String) {
		guard strand.uppercased() == strand else { return nil }
		
		self.strand = strand
	}
}
