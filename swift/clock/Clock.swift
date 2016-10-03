//
//  Clock.swift
//  helloWorld
//
//  Created by Roland Leth on 26.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Clock: CustomStringConvertible, Equatable {
	
	let hours: Int
	let minutes: Int
	let description: String
	
	
	// MARK: - Actions
	
	private static func normalizeToTwoDigits(_ value: Int) -> String {
		return (value < 10 ? "0" : "") + "\(value)"
	}

	func add(minutes: Int) -> Clock {
		return Clock(hours: hours, minutes: self.minutes + minutes)
	}
	
	func subtract(minutes: Int) -> Clock {
		return Clock(hours: hours, minutes: self.minutes - minutes)
	}
	
	static func ==(lhs: Clock, rhs: Clock) -> Bool {
		return lhs.hours == rhs.hours && lhs.minutes == rhs.minutes
	}
	
	
	// MARK: - Init
	
	init(hours: Int, minutes: Int = 0) {
		var hours = (hours + minutes / 60) % 24
		var minutes = minutes % 60
		
		if minutes < 0 {
			minutes = 60 + minutes
			hours -= 1
		}
		if hours < 0 {
			hours = 24 + hours
		}
		
		self.hours = hours
		self.minutes = minutes
		description = {
			let h = Clock.normalizeToTwoDigits(hours)
			let m = Clock.normalizeToTwoDigits(minutes)
			
			return "\(h):\(m)"
		}()
	}
	
}
