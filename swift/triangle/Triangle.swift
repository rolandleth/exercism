//
//  Triangle.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Triangle {
	
	private enum Kind: String {
		case Equilateral
		case Isosceles
		case Scalene
		case ErrorKind
	}
	
	let kind: String
	
	init(_ one: Float, _ two: Float, _ three: Float) {
		kind = { () -> Kind in
			for s in [one, two, three] where s <= 0 {
				return .ErrorKind
			}
			
			if one + two < three || one + three < two || two + three < one {
				return .ErrorKind
			}
			if one == two && two == three {
				return .Equilateral
			}
			if one == two || two == three || one == three {
				return .Isosceles
			}
			
			return .Scalene
		}().rawValue
	}
	
}
