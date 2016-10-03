//
//  Poker.swift
//  helloWorld
//
//  Created by Roland Leth on 01.11.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private extension String {
	
	subscript (index: Int) -> String {
		return "\(self[characters.index(startIndex, offsetBy: index)])"
	}
	
}

private struct Card: CustomStringConvertible {
	
	enum Rank: String {
		case A1, two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", ten = "10", J, Q, K, A
		
		var value: Int {
			switch self {
			case .A: return 14
			case .A1: return 1
			case .K: return 13
			case .Q: return 12
			case .J: return 11 // They're off by one to easily determine straights.
			default: return Int(rawValue)!
			}
		}
	}
	
	enum Suit: String {
		case spades = "♤"
		case hearts = "♡"
		case diamonds = "♢"
		case clubs = "♧"
		
		var value: Int {
			switch self {
			case .spades: return 4
			case .hearts: return 3
			case .diamonds: return 2
			case .clubs: return 1
			}
		}
	}
	
	// Dynamic since we might change A to A1.
	var description: String {
		return "\(rank.rawValue)\(suit.rawValue)"
	}
	var rank: Rank
	let suit: Suit
	
	init?(_ data: String) {
		guard (2...3) ~= data.characters.count else { return nil }
		
		let rawRank: String
		let rawSuite: String
		if data.characters.count == 3 {
			rawRank = data[0] + data[1]
			rawSuite = data[2]
		}
		else {
			rawRank = data[0]
			rawSuite = data[1]
		}
		
		guard
			let r = Rank(rawValue: rawRank),
			let s = Suit(rawValue: rawSuite) else { return nil }
		
		rank = r
		suit = s
	}
	
}

struct Poker {
	
	static func bestHand(_ hands: [String]) -> String {
		var hands: [PokerHand] = hands.flatMap { PokerHand($0) }.sorted { $0.value > $1.value }
		guard hands.count > 1 else { return hands.first!.description }
		
		func sortedScoreCards(for hand: PokerHand) -> [Card] {
			return hand.cards
				.filter { card in
					!hand.types.contains { $0.value == card.rank.value }
				}
				.sorted { $0.rank.value > $1.rank.value }
		}
		
		var winningHand = hands.first!
		
		outer: for (i, hand) in hands.enumerated() {
			guard i > 0 else { continue }
			guard hand.value == winningHand.value else { break }
			
			inner: for type in hand.types {
				switch type {
				case (.flush, _):
					// If it's a spade flush, update the current winning hand.
					guard hand.cards.first?.suit == .spades else { break }
					winningHand = hand
				case (.fourOfAKind, let value?):
					// If it's bigger, we already have our winning hand.
					if winningHand.types.first!.value! > value { break outer }
					// If it's equal, break the loop and calculate score cards.
					if winningHand.types.first!.value! == value { break inner }
					winningHand = hand
				case (.threeOfAKind, let value?):
					// If it's bigger, we already have our winning hand.
					if winningHand.types.first!.value! > value { break outer }
					// If it's equal, break the loop and calculate score cards.
					if winningHand.types.first!.value! == value { break }
					winningHand = hand
				case (.pair, let value?):
					// We can either have two pairs, or a full house, 
					// both of which mean there's a pair at the second index.
					let typeIndex = hand.types.index { $0.value == value }!
					let winningType = winningHand.types[typeIndex]
					// If it's bigger, we already have our winning hand.
					if winningType.value! > value { break outer }
					// If it's equal, break the loop and calculate score cards.
					if winningType.value! == value { break }
					winningHand = hand
				default: break
				}
			}
			
			let scoreCards = sortedScoreCards(for: hand)
			let winningScoreCards = sortedScoreCards(for: winningHand)
			
			for (si, scoreCard) in scoreCards.enumerated() {
				guard winningScoreCards[si].rank.value <= scoreCard.rank.value else { break }
				guard winningScoreCards[si].rank.value < scoreCard.rank.value else { continue }
				winningHand = hand
			}
		}
		
		return winningHand.description
	}
	
}

struct PokerHand: CustomStringConvertible {
	
	fileprivate enum Category: Int {
		case high
		case ace = 1 // For royal flush, to skip checking the card values.
		case pair = 5
		// Pair + pair = 10.
		case threeOfAKind = 11
		case straight
		case flush
		// Three + pair (full) = 16.
		case fourOfAKind = 17
		// Straight + flush = 25.
	}
	
	fileprivate let cards: [Card]
	fileprivate let value: Int
	fileprivate let types: [(type: Category, value: Int?)]
	
	var description: String
	
	init?(_ hand: String) {
		let cards = hand
			.components(separatedBy: " ")
			.flatMap { Card($0) }
		
		guard cards.count == 5 else { return nil }
		
		self.cards = cards
		description = cards.map { $0.description }.joined(separator: " ")
		
		var ranks = cards.map { $0.rank }.sorted { $0.value > $1.value }
		let suits = cards.map { $0.suit }
		var types: [(type: Category, value: Int?)] = []
		
		if Set(suits).count == 1 {
			types.append((.flush, nil))
		}
		
		if Set(ranks).count == 5 {
			func isStraight(_ ranks: [Card.Rank]) -> Bool {
				for (i, rank) in ranks.enumerated() {
					guard i > 0 else { continue }
					if rank.value != ranks[i - 1].value - 1 {
						return false
					}
				}
				return true
			}
			
			// Rank the Ace based on its positioning in a high or low straight.
			if ranks.first == .A {
				ranks.removeFirst()
				
				if ranks.last == .two, isStraight(ranks) {
					ranks.append(.A1)
				}
				else {
					ranks.insert(.A, at: 0)
				}
			}
			
			if isStraight(ranks) {
				if types.contains(where: { $0.type == .flush }) && ranks.first == .A {
					types.append((.ace, nil))
				}
				types.append((.straight, nil))
			}
		}
		
		var rankStructure: [Card.Rank: Int] = [:]
		for rank in ranks {
			rankStructure[rank] = (rankStructure[rank] ?? 0) + 1
		}
		
		for e in rankStructure.sorted(by: { $0.0.key.value > $0.1.key.value }) {
			switch e.value {
			case 4:
				types.append((.fourOfAKind, e.key.value))
			case 3:
				types.append((.threeOfAKind, e.key.value))
			case 2:
				types.append((.pair, e.key.value))
			default: break
			}
		}
		
		self.types = types.sorted { $0.type.rawValue > $1.type.rawValue }
		self.value = types.reduce(0) { $0 + $1.type.rawValue }
	}
	
}

/*
I don't think there's enough information for "tie for best pair: brake tide by suit",
I've found multiple rules regarding suit-tying, and most sources say it shouldn't happen anyway.
Why is hearts + diamonds > clubs + spades?
spades, hearts, diamonds, clubs (inverse alphabetical), they're equal.

Added tests for tied full house
(
name: "best tied full house",
hands: [
"4♤ 3♤ 8♤ J♤ K♤",
"2♢ 8♡ 8♢ 2♡ 8♧",
"8♡ 8♢ A♤ 8♧ A♢",
"3♡ A♡ 3♢ 3♧ A♧",
],
best:  "8♡ 8♢ A♤ 8♧ A♢"
)
*/
