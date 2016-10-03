//
//  Grains.swift
//  helloWorld
//
//  Created by Roland Leth on 26.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Grains {
	
	enum GrainsError: Error {
		case inputTooHigh(message: String)
		case inputTooLow(message: String)
	}
	
	static func square(_ value: Double) throws -> Double {
		guard value > 0 else {
			throw GrainsError.inputTooLow(
				message: "Input[\(Int(value))] invalid. Input should be between 1 and 64 (inclusive)")
		}
		guard value < 65 else {
			throw GrainsError.inputTooHigh(
				message: "Input[\(Int(value))] invalid. Input should be between 1 and 64 (inclusive)")
		}
		
		(0..<Int(value)).filter { values[$0] == nil }.forEach {
			values[$0] = pow(2, Double($0))
		}
		
		return values[Int(value - 1)]!
	}
	
	static var values: [Int: Double] = [:]
	static var total: Double {
		_ = try! square(64)
		// return values.reduce(0.0, { return $0 + $1.1 }) is not readable enough, at first glance.
		return values.reduce(0.0, { (total, current: (key: Int, value: Double)) -> Double in
			return total + current.value
		})
	}
	
}
