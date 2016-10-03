//
//  NumberSeries.swift
//  helloWorld
//
//  Created by Roland Leth on 11.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct NumberSeries {
	
	enum NumberSeriesError: Error {
		case spanLongerThanStringLength
		case invalidCharacter
		case negativeSpan
	}
	
	private let valid: Bool
	private let series: [Double]
	
	func largestProduct(_ digits: Int) throws -> Double {
		guard valid else { throw NumberSeriesError.invalidCharacter }
		guard digits > -1 else { throw NumberSeriesError.negativeSpan }
		guard digits > 0 else { return 1 }
		guard digits <= series.count else { throw NumberSeriesError.spanLongerThanStringLength }
		
		var product: Double = 1
		var maxProduct: Double = 0
		var counter = 0
		
		for (i, d) in series.enumerated() {
			guard d != 0 else {
				guard i + digits < series.count else { return maxProduct }
				
				product = 1
				counter = 0
				continue
			}
			
			if counter < digits {
				product = product * d
				counter += 1
				
				if i == series.count - 1 {
					return max(product, maxProduct)
				}
			}
			else if counter == digits {
				product = product * d / max(1, series[i - digits])
				maxProduct = max(product, maxProduct)
			}
		}
		
		return maxProduct
	}
	
	init(_ series: String) {
		self.series = series.characters.flatMap {
			guard let i = Int("\($0)") else { return nil }
			return Double(i)
		}
		valid = self.series.count == series.characters.count
	}
	
}
