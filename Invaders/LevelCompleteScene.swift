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

	override func didMove(to view: SKView) {
		self.backgroundColor = SKColor.black
		let startGameButton = SKSpriteNode(imageNamed: "nextlevelbtn")
		startGameButton.position = CGPoint(x: size.width/2,y: size.height/2 - 100)
		startGameButton.name = "nextlevel"
		addChild(startGameButton)

		// Set up the background star field - using SpriteKit Particle (rain)
		backgroundColor = SKColor.black
		let starField = SKEmitterNode(fileNamed: "StarField")
		starField?.position = CGPoint(x: size.width / 2,y: size.height)
		
		starField?.zPosition = -1000
		addChild(starField!)

		// Pulsating text
		self.backgroundColor = SKColor.black
		let invaderText = PulsatingText(fontNamed: "ChalkDuster")
		invaderText.setTextFontSizeAndPulsate("LEVEL COMPLETE", theFontSize: 50)
		invaderText.position = CGPoint(x: size.width/2,y: size.height/2 + 200)
		addChild(invaderText)

	}

	func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {

		for touch: AnyObject in touches {
			let touchLocation = touch.location(in: self)
			let touchedNode = self.atPoint(touchLocation)
			if (touchedNode.name == "nextlevel") {
				let gameOverScene = GameScene(size: size)
				gameOverScene.scaleMode = scaleMode
				let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
				view?.presentScene(gameOverScene,transition: transitionType)
			}
		}
	}

}
