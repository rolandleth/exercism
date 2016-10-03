//
//  Dominoes.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct Dominoes {
	
	typealias Domino = (left: Int, right: Int)
	
	let chained: Bool
	
	init(_ input: [Domino]) {
		guard !input.isEmpty else { chained = false; return }
		guard input.count > 1 else { chained = input.first!.left == input.first!.right; return }
		
		func arrange(dominoes: [Domino], after prev: Domino?) -> [Domino] {
			guard !dominoes.isEmpty else { return [] }
			
			var i = 0
			var result: [Domino] = []
			
			// This finishes in 0.08 seconds, and nothing changed except
			// for i in (0..<dominoes.count) finishes in 0.4 :|
			while i < dominoes.count - 1 {
				var remaining = dominoes
				var previous: Domino
				
				if prev == nil {
					// We're just starting, so don't append anything yet,
					// it'll happen in the next step.
					previous = remaining[0]
				}
				else {
					previous = prev!
					result = [previous]
				}
				
				let indexToRemove: Array<Domino>.Index
				if let index = remaining.index(where: {
					previous.right == $0.left || previous.right == $0.right
				}) {
					indexToRemove = index
				}
				else {
					indexToRemove = i
				}
				
				let firstDomino: Domino
				let piece = remaining[indexToRemove]
				
				if previous.right == piece.right {
					firstDomino = (piece.right, piece.left)
				}
				else {
					firstDomino = piece
				}
				remaining.remove(at: indexToRemove)
				
				if remaining.count == 1 {
					let next = remaining.first!
					
					if firstDomino.right == next.left {
						result = [previous, firstDomino, next]
					}
					else if firstDomino.right == next.right {
						let reversed: Domino = (next.right, next.left)
						result = [previous, firstDomino, reversed]
					}
					else {
						return []
					}
				}
				else {
					let next = arrange(dominoes: remaining, after: firstDomino)
					if !next.isEmpty {
						result += next
					}
				}
				
				if
					dominoes.count == result.count,
					result.first!.left == result.last!.right {
					break
				}
				
				i += 1
			}
			
			return result
		}
		
		let arranged = arrange(dominoes: input, after: nil)
		print(arranged)
		self.chained = arranged.count == input.count
			&& arranged.first!.left == arranged.last!.right
	}
	
}
