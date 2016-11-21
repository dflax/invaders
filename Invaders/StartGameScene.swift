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

	override func didMove(to view: SKView) {
		let startGameButton = SKSpriteNode(imageNamed: "newgamebtn.png")
		startGameButton.position = CGPoint(x: size.width/2,y: size.height/2 - 100)
		startGameButton.name = "startgame"
		addChild(startGameButton)

		// Set up the background star field - using SpriteKit Particle (rain)
		backgroundColor = SKColor.black
		let starField = SKEmitterNode(fileNamed: "StarField")
		starField?.position = CGPoint(x: size.width / 2,y: size.height)

		starField?.zPosition = -1000
		addChild(starField!)

		// Pulsating text on the screen
		let invaderText = PulsatingText(fontNamed: "ChalkDuster")
		invaderText.setTextFontSizeAndPulsate("INVADERZ", theFontSize: 50)
		invaderText.position = CGPoint(x: size.width/2,y: size.height/2 + 200)
		addChild(invaderText)

	}

	func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
		for touch: AnyObject in touches {
			let touchLocation = touch.location(in: self)
			let touchedNode = self.atPoint(touchLocation)
			if(touchedNode.name == "startgame"){
				let gameOverScene = GameScene(size: size)
				gameOverScene.scaleMode = scaleMode
				let transitionType = SKTransition.flipHorizontal(withDuration: 1.0)
				view?.presentScene(gameOverScene,transition: transitionType)
			}
		}
	}



}
