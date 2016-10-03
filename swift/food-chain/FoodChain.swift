//
//  FoodChain.swift
//  helloWorld
//
//  Created by Roland Leth on 25.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct FoodChain {
	
	private static func verses() -> [String] {
		let actors = [
			"fly", "spider", "bird", "cat", "dog",
			"goat", "cow", "horse"
		]
		let conclusions = [
			"placeholder",
			"It wriggled and jiggled and tickled inside her.",
			"How absurd to swallow a bird!",
			"Imagine that, to swallow a cat!",
			"What a hog, to swallow a dog!",
			"Just opened her throat and swallowed a goat!",
			"I don't know how she swallowed a cow!",
			"She's dead, of course!"
		]
		
		let iKnow = "I know an old lady who swallowed a"
		var output = [
			"\(iKnow) fly.\nI don't know why she swallowed the fly. Perhaps she'll die."
		]
		
		for (i, actor) in actors.enumerated() {
			guard i > 0 else { continue }
			
			var new = "\(iKnow) \(actor).\n\(conclusions[i])"
			let previous = output[i - 1].replacingOccurrences(of: iKnow, with: "")
			
			if i < actors.count - 1 {
				new += "\nShe swallowed the \(actor) to catch the" + previous
			}
			
			// Just to allow other potential descriptions of actors, that need to propagate.
			// It is sharp and pointy. ->
			// [...] to catch the old actor that is sharp and pointy.
			let prevActor = actors[i - 1]
			let prevActorIt = " \(prevActor).\nIt "
			
			if previous.hasPrefix(prevActorIt) {
				let prevActorThat = " \(prevActor) that "
				new = new.replacingOccurrences(of: prevActorIt,
				                               with: prevActorThat)
			}
			else {
				new = new.replacingOccurrences(of: conclusions[i - 1] + "\n",
				                               with: "")
			}
			
			output.append(new)
		}
		
		return output
	}
	
	static func song() -> String {
		return verses().joined(separator: "\n\n")
	}
	
	static func verse(_ verse: Int) -> String {
		let verses = self.verses()
		guard verse <= verses.count else { return "" }
		return verses[verse - 1]
	}
	
}
