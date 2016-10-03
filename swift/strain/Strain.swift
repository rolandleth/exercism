//
//  Strain.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

extension Collection {
	
	func keep(_ transform: (Iterator.Element) -> Bool) -> [Iterator.Element] {
		var a: [Iterator.Element] = []
		
		for e in self where transform(e) {
			a.append(e)
		}
		
		return a
	}
	
	func discard(_ transform: (Iterator.Element) -> Bool) -> [Iterator.Element] {
		return keep { !transform($0) }
	}
	
}
