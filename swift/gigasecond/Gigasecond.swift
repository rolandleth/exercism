//
//  Gigasecond.swift
//  helloWorld
//
//  Created by Roland Leth on 05.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Gigasecond {
	
	let description: String
	
	init?(from: String) {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		
		guard
			let date = formatter.date(from: from)
		else { return nil }
		
		let newDate = Date(timeInterval: pow(10, 9), since: date)
		description = formatter.string(from: newDate)
	}
	
}
