//
//  SpaceAge.swift
//  helloWorld
//
//  Created by Roland Leth on 05.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension Double {
	
	func roundedToSecondDigit(factor: Double) -> Double {
		let s = Double(31_557_600) * factor
		return floor((self / s) * 100 + 0.5) / 100
	}
	
}

struct SpaceAge {
	
	let onEarth: Double
	let onMercury: Double
	let onVenus: Double
	let onMars: Double
	let onJupiter: Double
	let onSaturn: Double
	let onUranus: Double
	let onNeptune: Double
	let seconds: Int
	
	init(_ age: Double) {
		seconds = Int(age)
		onEarth = age.roundedToSecondDigit(factor: 1)
		onMercury = age.roundedToSecondDigit(factor: 0.2408467)
		onVenus = age.roundedToSecondDigit(factor: 0.61519726)
		onMars = age.roundedToSecondDigit(factor: 1.8808158)
		onJupiter = age.roundedToSecondDigit(factor: 11.862615)
		onSaturn = age.roundedToSecondDigit(factor: 29.447498)
		onUranus = age.roundedToSecondDigit(factor: 84.016846)
		onNeptune = age.roundedToSecondDigit(factor: 164.79132)
	}
	
}
