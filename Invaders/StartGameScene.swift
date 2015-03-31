//
//  StartGameScene.swift
//  Invaders
//
//  Created by Daniel Flax on 3/31/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: SKScene {

	override func didMoveToView(view: SKView) {
		let startGameButton = SKSpriteNode(imageNamed: "newgamebtn.png")
		startGameButton.position = CGPointMake(size.width/2,size.height/2 - 100)
		startGameButton.name = "startgame"
		addChild(startGameButton)
	}

	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		for touch: AnyObject in touches {
			let touchLocation = touch.locationInNode(self)
			let touchedNode = self.nodeAtPoint(touchLocation)
			if(touchedNode.name == "startgame"){
				let gameOverScene = GameScene(size: size)
				gameOverScene.scaleMode = scaleMode
				let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
				view?.presentScene(gameOverScene,transition: transitionType)
			}
		}
	}



}