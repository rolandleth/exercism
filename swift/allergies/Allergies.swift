//
//  Allergies.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Allergies {
	
	enum Allergy: UInt {
		case eggs = 1
		case peanuts = 2
		case shellfish = 4
		case strawberries = 8
		case tomatoes = 16
		case chocolate = 32
		case pollen = 64
		case cats = 128
	}
	
	private let allergies: [Allergy]
	
	func hasAllergy(_ allergy: Allergy) -> Bool {
		return allergies.contains(allergy)
	}
	
	init(_ score: UInt) {
		var s = score
		let a: [Allergy] = [
			.cats, .pollen, .chocolate, .tomatoes,
			.strawberries, .shellfish, .peanuts, .eggs
		]
		var allergies: [Allergy] = []
		
		a.forEach {
			guard s >= $0.rawValue else { return }
			
			allergies.append($0)
			s -= $0.rawValue
		}
		
		self.allergies = allergies
	}
	
}
