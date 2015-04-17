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
	}

	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

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