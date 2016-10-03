//
//  Bowling.swift
//  helloWorld
//
//  Created by Roland Leth on 31.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation


fileprivate class Frame {
	
	typealias Roll = (shot: Bool, pins: Int)
	
	enum State {
		case none
		case open
		case spare
		case strike
	}
	
	var nextFrame: Frame?
	var number = 1
	var first: Roll = (false, 0)
	var second: Roll = (false, 0)
	var total: Int { return first.pins + second.pins }
	var state: State {
		switch (first, second) {
		case ((true, 10), _): return .strike
		case ((true, _), (true, _)) where total == 10: return .spare
		case (_, (true, _)): return .open
		default: return .none
		}
	}
	
}

struct Bowling {
	
	enum BowlingError: Error {
		case invalidNumberOfPins
		case tooManyPinsInFrame
		case gameInProgress
		case gameIsOver
	}
	
	private let validPins = (0...10)
	private var frames: [Frame] = []
	private var currentFrame: Frame? { return frames.last }
	private var extraRoll: Frame.Roll = (false, 0)
	private var isLastFrame: Bool { return frames.count == 10 }
	
	mutating func roll(pins: Int) throws {
//		guard case validPins = pins else { throw BowlingError.invalidNumberOfPins }
		guard validPins ~= pins else { throw BowlingError.invalidNumberOfPins }
		guard frames.count <= 10, !extraRoll.shot else { throw BowlingError.gameIsOver }
		
		var frame: Frame

		if let current = currentFrame, !current.second.shot || frames.count == 10 {
			frame = currentFrame!
		}
		else {
			frame = Frame()
			frames.last?.nextFrame = frame
			frames.append(frame)
		}
		
		if !frame.first.shot {
			frame.first = (true, pins)
			
			if pins == 10, frames.count < 10 {
				frame.second = (true, 0)
			}
		}
		else if !frame.second.shot {
			frame.second = (true, pins)
		}
		else {
			extraRoll = (true, pins)
		}
		
		// Don't award the extra roll on frame 0 unless strike, or spare:
		// 3 | ? | No, 3 | 6 | No, 3 | 7 | Yes.
		if isLastFrame, frame.second.shot, frame.total < 10 {
			extraRoll = (true, 0)
		}
		
		if !isLastFrame, !(validPins ~= frame.total) {
			throw BowlingError.tooManyPinsInFrame
		}
		// 2 | 5 | not reaching this point, 5 | 5 | any, 10 | 6 | 6 - wrong.
		if
			isLastFrame,
			frame.state == .strike,
			frame.second.pins + extraRoll.pins > 10 {
			throw BowlingError.tooManyPinsInFrame
		}
	}
	
	mutating func rollNTimes(rolls: Int, pins: Int) throws {
		for _ in (0..<rolls) {
			try self.roll(pins: pins)
		}
	}
	
	func score() throws -> Int {
		guard isLastFrame, !(frames.contains { !$0.second.shot }), extraRoll.shot
			else { throw BowlingError.gameInProgress }
		
		return frames.enumerated().reduce(0) { t, enumeration in
			var bonus = 0
			let frame = enumeration.element
			let i = enumeration.offset
			
			if i == 9 {
				bonus = extraRoll.pins
			}
			else if frame.state == .spare {
				bonus = frame.nextFrame!.first.pins
			}
			else if frame.state == .strike {
				bonus = frame.nextFrame!.first.pins
				
				if frame.nextFrame!.state == .strike {
					// If there's no next.next frame, it means we are at frame 9.
					// If we have a strike at frame 9, we need to add frame 10's first + second.
					bonus += frame.nextFrame!.nextFrame?.first.pins ?? frame.nextFrame!.second.pins
				}
				else {
					bonus += frame.nextFrame!.second.pins
				}
			}
			
			return t + frame.total + bonus
		}
	}

}
