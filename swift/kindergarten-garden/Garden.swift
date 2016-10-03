//
//  Garden.swift
//  helloWorld
//
//  Created by Roland Leth on 26.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension String {
	
	subscript (index: Int) -> Character {
		return self[characters.index(startIndex, offsetBy: index)]
	}
	
}

struct Garden {
	
	enum Plant: Character {
		case clover = "C"
		case grass = "G"
		case radishes = "R"
		case violets = "V"
	}
	
	private let flowerDiagram: [String]
	static private let allChildren = [
		"Alice", "Bob", "Charlie", "David",
		"Eve", "Fred", "Ginny", "Harriet",
		"Ileana", "Joseph", "Kincaid", "Larry"
	]
	private let children: [String]
	
	func plantsForChild(_ child: String) -> [Plant] {
		// We assume the input is correct; could've had a guard with a nil return otherwise.
		let childPosition = children.index(of: child)! * 2
		
		return [
			flowerDiagram[0][childPosition], flowerDiagram[0][childPosition + 1],
			flowerDiagram[1][childPosition], flowerDiagram[1][childPosition + 1]
		].map { Plant(rawValue: $0)! }
	}
	
	init(_ flatDiagram: String, children: [String] = Garden.allChildren) {
		flowerDiagram = flatDiagram.components(separatedBy: "\n")
		self.children = children.sorted()
	}
	
}
