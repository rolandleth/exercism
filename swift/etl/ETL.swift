//
//  ETL.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct ETL {
	
	static func transform(_ old: [Int: [String]]) -> [String: Int] {
		var new: [String: Int] = [:]
		
		old.forEach { k, v in
			v.forEach {
				new[$0.lowercased()] = k
			}
		}
		
		return new
	}
	
}
