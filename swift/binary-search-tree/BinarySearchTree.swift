//
//  BinarySearchTree.swift
//  helloWorld
//
//  Created by Roland Leth on 20.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

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

struct BinarySearchTree {
	
	private var allValues: [Int] = []
	private var topNode: Node<Int>
	
	var data: Int { return topNode.data }
	var left: Node<Int>? { return topNode.left }
	var right: Node<Int>? { return topNode.right }
	
	private func add(_ value: Int, to node: inout Node<Int>) {
		if value <= node.data {
			guard node.left != nil else {
				return node.left = Node(data: value)
			}
			
			return add(value, to: &node.left!)
		}
		
		guard node.right != nil else {
			return node.right = Node(data: value)
		}
		
		add(value, to: &node.right!)
	}
	
	mutating func insert(_ value: Int) {
		allValues.append(value)
		add(value, to: &topNode)
	}
	
	func allData() -> [Int] {
		return allValues.sorted()
	}
	
	init(_ value: Int) {
		allValues = [value]
		topNode = Node(data: value)
	}
}
