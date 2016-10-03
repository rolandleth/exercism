//
//  Raindrops.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Raindrops {
	
	let sounds: String
	
	init(_ number: Int) {
		var s = ""
		
		if number % 3 == 0 {
			s += "Pling"
		}
		
		if number % 5 == 0 {
			s += "Plang"
		}
		
		if number % 7 == 0 {
			s += "Plong"
		}
		
		if s.isEmpty {
			s = "\(number)"
		}
		
		sounds = s
	}
	
}
