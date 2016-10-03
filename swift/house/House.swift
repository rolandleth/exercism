//
//  House.swift
//  helloWorld
//
//  Created by Roland Leth on 12.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct House {
	
	static func recite() -> String {
		let actors = [
			"house", "malt", "rat", "cat", "dog",
			"cow with the crumpled horn",
			"maiden all forlorn",
			"man all tattered and torn",
			"priest all shaven and shorn",
			"rooster that crowed in the morn",
			"farmer sowing his corn",
			"horse, hound, horn"
		]
		let actions = [
			"built", "lay in", "ate",
			"killed", "worried", "tossed",
			"milked", "kissed", "married",
			"woke", "kept", "belonged to"
		]
		
		let thisIs = "This is"
		var output = [
			"\(thisIs) the house that Jack built."
		]
		
		for (i, a) in actors.enumerated() {
			guard i > 0 else { continue }
			
			let previous = "\(thisIs) the "
				+ a.replacingOccurrences(of: ",", with: " and the")
				+ "\nthat "
				+ actions[i]
				+ output[i - 1].replacingOccurrences(of: thisIs, with: "")
			
			output.append(previous)
		}
		
		return output.joined(separator: "\n\n")
	}
	
}
