//
//  LevelCompleteScene.swift
//  Invaders
//
//  Created by Daniel Flax on 4/17/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import Foundation
import SpriteKit

class LevelCompleteScene: SKScene {

	override func didMoveToView(view: SKView) {
		self.backgroundColor = SKColor.blackColor()
		let startGameButton = SKSpriteNode(imageNamed: "nextlevelbtn")
		startGameButton.position = CGPointMake(size.width/2,size.height/2 - 100)
		startGameButton.name = "nextlevel"
		addChild(startGameButton)

		// Set up the background star field - using SpriteKit Particle (rain)
		backgroundColor = SKColor.blackColor()
		let starField = SKEmitterNode(fileNamed: "StarField")
		starField.position = CGPointMake(size.width / 2,size.height)
		
		starField.zPosition = -1000
		addChild(starField)
	}

	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

		for touch: AnyObject in touches {
			let touchLocation = touch.locationInNode(self)
			let touchedNode = self.nodeAtPoint(touchLocation)
			if (touchedNode.name == "nextlevel") {
				let gameOverScene = GameScene(size: size)
				gameOverScene.scaleMode = scaleMode
				let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
				view?.presentScene(gameOverScene,transition: transitionType)
			}
		}
	}

}