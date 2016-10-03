//
//  Classifier.swift
//  helloWorld
//
//  Created by Roland Leth on 19.12.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

enum classifier {
	
	case equal
	case sublist
	case superlist
	case unequal
	
	init(listOne: [Int], listTwo: [Int]) {
		if listOne == listTwo {
			self = .equal
			return
		}
		
		let firstList = listOne.map { "\($0)" }.joined(separator: "|")
		let secondList = listTwo.map { "\($0)" }.joined(separator: "|")
		
		if listOne.isEmpty || secondList.contains(firstList) {
			self = .sublist
			return
		}
		
		if listTwo.isEmpty || firstList.contains(secondList) {
			self = .superlist
			return
		}
		
		self = .unequal
	}
	
}
