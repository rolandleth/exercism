//
//  RomanNumeral.swift
//  helloWorld
//
//  Created by Roland Leth on 06.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct RomanNumeral: CustomStringConvertible {
	
	let description: String
	
	init(_ int: Int) {
		var int = int
		var description = ""
		
		while int > 0 {
			switch int {
			case 1..<4: int -= 1; description += "I"
			case 4: int -= 4; description += "IV"
			case 5: int -= 5; description += "V"
			case 6: int -= 6; description += "VI"
			case 7: int -= 7; description += "VII"
			case 8: int -= 8; description += "VIII"
			case 9: int -= 9; description += "IX"
			case 10..<40: int -= 10; description += "X"
			case 40..<50: int -= 40; description += "XL"
			case 50..<90: int -= 50; description += "L"
			case 90..<100: int -= 90; description += "XC"
			case 100..<400: int -= 100; description += "C"
			case 400..<500: int -= 400; description += "CD"
			case 500..<900: int -= 500; description += "D"
			case 900..<1000: int -= 900; description += "CM"
			default: int -= 1000; description += "M"
			}
		}
		
		self.description = description
	}
	
}
