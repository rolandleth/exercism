//
//  Element.swift
//  helloWorld
//
//  Created by roland on 05/10/2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

class Element<T> {
	
	var value: T?
	var next: Element?
	
	func reverseElements() -> Element {
		guard next != nil else { return self }
		return Element(next?.value, Element(value))
	}
	
	func toArray() -> [T] {
		func toArray(from current: Element?) -> [T?] {
			guard current?.next != nil else { return [current?.value] }
			return [current?.value] + toArray(from: current?.next)
		}
		return toArray(from: self).flatMap { $0 }
	}
	
	static func fromArray(_ array: [T]) -> Element {
		let element = Element(array.first)
		var current: Element? = element
		
		array.enumerated().forEach {
			guard $0 != 0 else { return }
			
			current?.next = Element($1)
			current = current?.next
		}
		
		return element
	}
	
	init(_ value: T? = nil, _ next: Element? = nil) {
		self.value = value
		self.next = next
	}
	
}
