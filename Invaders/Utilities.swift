//
//  Utilities.swift
//  Invaders
//
//  Created by Daniel Flax on 4/9/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import Foundation

extension Array {

	// Extend the Array object with a random element function
	func randomElement() -> T {
		let index = Int(arc4random_uniform(UInt32(self.count)))
		return self[index]
	}

}