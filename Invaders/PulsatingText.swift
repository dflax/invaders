//
//  PulsatingText.swift
//  Invaders
//
//  Created by Daniel Flax on 4/18/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit
import SpriteKit

class PulsatingText : SKLabelNode {

	func setTextFontSizeAndPulsate(theText: String, theFontSize: CGFloat) {
		self.text = theText
		self.fontSize = theFontSize
		let scaleSequence = SKAction.sequence([SKAction.scaleTo(2, duration: 1),SKAction.scaleTo(1.0, duration:1)])
		let scaleForever = SKAction.repeatActionForever(scaleSequence)
		self.runAction(scaleForever)
	}


}