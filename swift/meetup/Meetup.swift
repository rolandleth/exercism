//
//  Meetup.swift
//  helloWorld
//
//  Created by Roland Leth on 05.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Meetup: CustomStringConvertible {
	
	private var calendar = Calendar.current
	private var components = DateComponents()
	var description: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.string(from: calendar.date(from: components)!)
	}
	
	func day(_ day: Int, which options: String) -> Meetup {
		var meetup = self
		var count: Int = {
			switch options {
			case "2nd": return 2
			case "3rd": return 3
			case "4th": return 4
			case "last": return 5
			default: return 1
			}
		}()
		
		let teenth = options == "teenth"
		let start = teenth ? 13 : components.day!
		let end = teenth ? 19 : 31
		
		for d in (start...end) {
			var c = components
			c.day = d
			
			guard
				let date = calendar.date(from: c),
				let nc = Optional(calendar.dateComponents([.month, .day, .weekday], from: date)),
				nc.month == components.month,
				nc.weekday == day else { continue }
			guard count == 1 else { count -= 1; continue }
			
			meetup.components.day = nc.day
			break
		}
		
		return meetup
	}
	
	init(year: Int, month: Int) {
		components.year = year
		components.month = month
		components.day = 1
		components.timeZone = TimeZone(secondsFromGMT: 0)
	}
	
}
