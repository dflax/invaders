//
//  Player.swift
//  Invaders
//
//  Created by Daniel Flax on 4/6/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {

	fileprivate var canFire = true
	fileprivate var invincible = false

	fileprivate var lives:Int = 3 {
		didSet {
			if(lives < 0){
				kill()
			} else {
				respawn()
			}
		}
	}

	init() {
		let texture = SKTexture(imageNamed: "player1")
		super.init(texture: texture, color: SKColor.clear, size: texture.size())

		self.physicsBody = SKPhysicsBody(texture: self.texture!,size:self.size)
		self.physicsBody?.isDynamic = true
		self.physicsBody?.usesPreciseCollisionDetection = false
		self.physicsBody?.categoryBitMask = CollisionCategories.Player
		self.physicsBody?.contactTestBitMask = CollisionCategories.InvaderBullet | CollisionCategories.Invader
		self.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
		self.physicsBody?.allowsRotation = false

		animate()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	fileprivate func animate(){
		var playerTextures:[SKTexture] = []
		for i in 1...2 {
			playerTextures.append(SKTexture(imageNamed: "player\(i)"))
		}
		let playerAnimation = SKAction.repeatForever( SKAction.animate(with: playerTextures, timePerFrame: 0.1))
		self.run(playerAnimation)
	}

	func die () {
		if (invincible == false) {
			lives -= 1
		}
	}

	func kill() {
		invaderNum = 1

		let gameOverScene = StartGameScene(size: self.scene!.size)
		gameOverScene.scaleMode = self.scene!.scaleMode

		let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
		self.scene!.view!.presentScene(gameOverScene,transition: transitionType)
	}

	func respawn() {

		// Set the player to invincible for a little bit after a respawn
		invincible = true

		let fadeOutAction = SKAction.fadeOut(withDuration: 0.4)
		let fadeInAction = SKAction.fadeIn(withDuration: 0.4)
		let fadeOutIn = SKAction.sequence([fadeOutAction,fadeInAction])
		let fadeOutInAction = SKAction.repeat(fadeOutIn, count: 5)
		let setInvicibleFalse = SKAction.run(){
			self.invincible = false
		}
		run(SKAction.sequence([fadeOutInAction,setInvicibleFalse]))
	}

	func fireBullet(_ scene: SKScene){

		if(!canFire){
			return
		} else {
			canFire = false
			let bullet = PlayerBullet(imageName: "laser",bulletSound: "laser.mp3")
			bullet.position.x = self.position.x
			bullet.position.y = self.position.y + self.size.height/2
			scene.addChild(bullet)

			let moveBulletAction = SKAction.move(to: CGPoint(x:self.position.x,y:scene.size.height + bullet.size.height), duration: 1.0)
			let removeBulletAction = SKAction.removeFromParent()
			bullet.run(SKAction.sequence([moveBulletAction,removeBulletAction]))
			let waitToEnableFire = SKAction.wait(forDuration: 0.5)

			run(waitToEnableFire,completion:{
				self.canFire = true
			})
		}
	}



}
