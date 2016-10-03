//
//  Accumulate.swift
//  helloWorld
//
//  Created by Roland Leth on 31.08.2016.
//  Copyright © 2016 exercism.io. All rights reserved.
//

extension Array {
	
	func accumulate<T>(_ closure: @escaping (_ input: Element) -> T) -> [T] {
		var output: [T] = []
		
		forEach {
			output.append(closure($0))
		}
		
		return output
	}
	
}
