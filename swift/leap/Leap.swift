//
//  Leap.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Year {
	
	let isLeapYear: Bool
	
	init(calendarYear year: Int) {
		isLeapYear = year % 4 == 0 && (year % 400 == 0 || year % 100 != 0)
	}
	
}
