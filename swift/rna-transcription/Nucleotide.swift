//
//  Nucleotide.swift
//  helloWorld
//
//  Created by Roland Leth on 07.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct Nucleotide {
	
	let complementOfDNA: String
	
	init(_ strand: String) {
		complementOfDNA = strand.characters.map {
			switch $0 {
			case "G": return "C"
			case "C": return "G"
			case "T": return "A"
			default: return "U"
			}
		}.joined(separator: "")
	}
	
}
