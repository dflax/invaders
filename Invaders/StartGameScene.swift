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
		let startGameButton = SKSpriteNode(imageNamed: "newgamebtn")
		startGameButton.position = CGPointMake(size.width/2,size.height/2 - 100)
		startGameButton.name = "startgame"
		addChild(startGameButton)
	}

}