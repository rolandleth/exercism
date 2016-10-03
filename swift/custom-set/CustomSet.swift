//
//  CustomSet.swift
//  helloWorld
//
//  Created by Roland Leth on 26.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct CustomSet<Element: Hashable>: Equatable {
	
	private var hashes: [Int: Element] = [:]
	
	var items: [Element] {
		return Array(hashes.values)
	}
	var size: Int {
		return hashes.count
	}
	var toSortedArray: [Element] {
		return items.sorted { $0.hashValue < $1.hashValue }
	}
	
	
	// MARK: - Inclusion
	
	func intersection(_ other: CustomSet) -> CustomSet {
		var new: [Element] = []
		
		for otherItem in other.items where containsMember(otherItem) {
			new.append(otherItem)
		}
		
		return CustomSet(new)
	}
	
	func difference(_ other: CustomSet) -> CustomSet {
		var new = self
		
		for otherItem in other.items where new.containsMember(otherItem) {
			new.delete(otherItem)
		}
		
		return new
	}
	
	func isDisjoint(_ other: CustomSet) -> Bool {
		return self == difference(other)
	}
	
	func isSupersetOf(_ other: CustomSet) -> Bool {
		return other.difference(self).size == 0
	}
	
	
	func containsMember(_ item: Element) -> Bool {
		return hashes[item.hashValue] != nil
	}
	
	
	// MARK: - Addition
	
	mutating func put(_ item: Element) {
		hashes[item.hashValue] = item
	}
	
	func union(_ other: CustomSet) -> CustomSet {
		return CustomSet(items + other.items)
	}
	
	
	// MARK: - Removal

	mutating func removeAll() {
		hashes.removeAll()
	}
	
	mutating func delete(_ item: Element) {
		hashes.removeValue(forKey: item.hashValue)
	}
	
	
	// MARK: - Init
	
	init(_ items: [Element]) {
		for item in items {
			if hashes[item.hashValue] != nil { continue }
			hashes[item.hashValue] = item
		}
	}
	
	static func ==(lhv: CustomSet, rhv: CustomSet) -> Bool {
		return lhv.hashes == rhv.hashes
	}
	
}
