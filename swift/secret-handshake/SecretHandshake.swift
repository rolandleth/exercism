//
//  SecretHandshake.swift
//  helloWorld
//
//  Created by roland on 05/10/2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

struct SecretHandshake {
	
	enum Command: Int {
		case wink = 1
		case doubleWink = 2
		case closeYourEyes = 4
		case jump = 8
		case revert = 16
	}
	
	let commands: [String]
	
	init(_ code: Int) {
		let allCommands: [Command] = [.wink, .doubleWink, .closeYourEyes, .jump, .revert]
		
		func command(from value: Int) -> String {
			switch value {
			case 1: return "wink"
			case 2: return "double blink"
			case 4: return "close your eyes"
			default: return "jump"
			}
		}
		
		commands = allCommands.reduce([String]()) {
			guard code & $1.rawValue != 0 else { return $0 }
			guard $1 != .revert else { return $0.reversed() }
			
			return $0 + [command(from: $1.rawValue)]
		}
	}
	
}
