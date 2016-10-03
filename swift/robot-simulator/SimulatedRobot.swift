//
//  SimulatedRobot.swift
//  helloWorld
//
//  Created by Roland Leth on 30.09.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct SimulatedRobot {
	
	enum Command: Character {
		case advance = "A"
		case turnLeft = "L"
		case turnRight = "R"
	}
	
	enum Direction {
		case north
		case east
		case south
		case west
	}
	
	var bearing = Direction.north
	var coordinates = [0, 0]
	
	
	// MARK: - Orientation

	mutating func orient(_ direction: Direction) {
		bearing = direction
	}
	
	mutating func turnRight() {
		switch bearing {
		case .north: orient(.east)
		case .east: orient(.south)
		case .south: orient(.west)
		case .west: orient(.north)
		}
	}
	
	mutating func turnLeft() {
		switch bearing {
		case .north: orient(.west)
		case .east: orient(.north)
		case .south: orient(.east)
		case .west: orient(.south)
		}
	}
	
	
	// MARK: - Placement
	
	mutating func advance() {
		switch bearing {
		case .north: at(x: coordinates[0], y: coordinates[1] + 1)
		case .east: at(x: coordinates[0] + 1, y: coordinates[1])
		case .south: at(x: coordinates[0], y: coordinates[1] - 1)
		case .west: at(x: coordinates[0] - 1, y: coordinates[1])
		}
	}

	mutating func place(x: Int, y: Int, direction: Direction) {
		coordinates = [x, y]
		bearing = direction
	}
	
	mutating func at(x: Int, y: Int) {
		place(x: x, y: y, direction: bearing)
	}
	
	
	// MARK: - Commands
	
	private mutating func evaluate(command: Command) {
		switch command {
		case .advance: advance()
		case .turnLeft: turnLeft()
		case .turnRight: turnRight()
		}
	}
	
	mutating func evaluate(_ sequence: String) {
		instructions(sequence).forEach {
			self.evaluate(command: $0)
		}
	}
	
	func instructions(_ sequence: String) -> [Command] {
		return sequence.characters.flatMap { Command(rawValue: $0) }
	}
	
}
