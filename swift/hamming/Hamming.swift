//
//  Hamming.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

private extension String {
	
	subscript (index: Int) -> Character {
		return self[characters.index(startIndex, offsetBy: index)]
	}
	
}

struct Hamming {
	
	static func compute(_ lhv: String, against rhv: String) -> Int? {
		guard lhv.characters.count == rhv.characters.count else { return nil }
		return lhv.characters.enumerated().filter { $0.element != rhv[$0.offset] }.count
	}
	
}
