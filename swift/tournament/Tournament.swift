//
//  Tournament.swift
//  helloWorld
//
//  Created by Roland Leth on 31.10.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

import Foundation

private struct Team {
	
	let name: String
	var wins: Int
	var draws: Int
	var losses: Int
	var points: Int { return wins * 3 + draws }
	var matches: Int { return wins + draws + losses }
	
}

struct Tournament {
	
	func tally(_ input: String) -> String {
		let matches = input.components(separatedBy: "\n")
		var teams: [Team] = []
		
		func processResult(_ result: String, for team: inout Team, left: Bool) {
			switch (result, left) {
			case ("win", true), ("loss", false): team.wins += 1
			case ("win", false), ("loss", true): team.losses += 1
			default: team.draws += 1
			}
		}
		
		matches.forEach {
			let data = $0.components(separatedBy: ";")
			guard
				data.count == 3,
				let result = Optional(data[2]),
				result == "win" || result == "draw" || result == "loss"
				else { return }
			
			(0...1).forEach { i in
				let left = i == 0
				
				if let idx = (teams.index { $0.name == data[i] }) {
					return processResult(result, for: &teams[idx], left: left)
				}
				
				var team = Team(name: data[i], wins: 0, draws: 0, losses: 0)
				processResult(result, for: &team, left: left)
				teams.append(team)
			}
		}
		
		func f(_ value: Int) -> String {
			return (value < 10 ? " " : "") + "\(value)"
		}
		
		let header = "Team                           | MP |  W |  D |  L |  P\n"
		let prefixSize = header.components(separatedBy: "|").first!.characters.count
		return header + teams
			.sorted { $0.0.points > $0.1.points }
			.map { t -> String in
				let suffix = "| \(f(t.matches)) | \(f(t.wins)) | \(f(t.draws)) | \(f(t.losses)) | \(f(t.points))"
				let nameSize = t.name.characters.count
				let prefix = t.name + String(repeating: " ", count: prefixSize - nameSize)
				return "\(prefix)\(suffix)"
			}
			.joined(separator: "\n")
	}
	
}
