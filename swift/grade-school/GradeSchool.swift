//
//  GradeSchool.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

struct GradeSchool {
	
	var sortedRoster: [Int: [String]] {
		var sr: [Int: [String]] = [:]
		
		roster.forEach { k, v in sr[k] = v.sorted() }
		
		return sr
	}
	var roster: [Int: [String]] = [:]
	
	
	// MARK: - Actions

	mutating func addStudent(_ student: String, grade: Int) {
		guard roster[grade] != nil else {
			return roster[grade] = [student]
		}

		roster[grade]!.append(student)
	}
	
	func studentsInGrade(_ grade: Int) -> [String] {
		return roster.filter { $0.key == grade }.first?.value ?? []
	}
	
}
