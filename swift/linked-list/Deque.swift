//
//  Deque.swift
//  helloWorld
//
//  Created by Roland Leth on 24.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

/*
In the BinarySearchTree exercise I also used a node,
which had imposed variable names and had to be public,
so I just adapted it to use generics, and added new variables,
because left / right felt wrong for this use:

class Node<T> {
	let data: T
	var left: Node?
	var right: Node?
	
	var previous: Node? {
		get { return left }
		set { left = newValue }
	}
	var next: Node? {
		get { return right }
		set { right = newValue }
	}

	init(data: T, left: Node? = nil, right: Node? = nil, previous: Node? = nil, next: Node? = nil) {
		self.data = data
		self.left = previous ?? left
		self.right = next ?? right
	}
}
*/

class Deque<T> {
	
	private var first: Node<T>? = nil
	private var last: Node<T>? = nil
	
	
	private func create(data: T) {
		first = Node(data: data)
		last = first
	}
	
	
	// MARK: - Back

	func push(_ data: T) {
		guard first != nil && last != nil else {
			return create(data: data)
		}
		
		let n = Node(data: data, previous: last)
		last?.next = n
		last = n
	}
	
	func pop() -> T? {
		let n = last
		
		last = n?.previous
		last?.next = nil
		
		return n?.data
	}
	
	
	// MARK: - Front

	func shift() -> T? {
		let n = first
		
		first = n?.next
		last?.previous = nil
		
		return n?.data
	}
	
	func unshift(_ data: T) {
		guard first != nil && last != nil else {
			return create(data: data)
		}
		
		let n = Node(data: data, next: first)
		first?.previous = n
		first = n
	}
	
}
