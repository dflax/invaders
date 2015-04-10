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

	private var canFire = true

	override init() {
		let texture = SKTexture(imageNamed: "player1")
		super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
		animate()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	private func animate(){
		var playerTextures:[SKTexture] = []
		for i in 1...2 {
			playerTextures.append(SKTexture(imageNamed: "player\(i)"))
		}
		let playerAnimation = SKAction.repeatActionForever( SKAction.animateWithTextures(playerTextures, timePerFrame: 0.1))
		self.runAction(playerAnimation)
	}

	func die (){
	}

	func kill(){
	}

	func respawn(){
	}

	func fireBullet(scene: SKScene){

println("fireBullet in Player")

		if(!canFire){
			return
		} else {
			canFire = false
println("canFire starting")
			let bullet = PlayerBullet(imageName: "laser",bulletSound: "laser.mp3")
			bullet.position.x = self.position.x
			bullet.position.y = self.position.y + self.size.height/2
			scene.addChild(bullet)
println("added bullet to scene")
			let moveBulletAction = SKAction.moveTo(CGPoint(x:self.position.x,y:scene.size.height + bullet.size.height), duration: 1.0)
			let removeBulletAction = SKAction.removeFromParent()
			bullet.runAction(SKAction.sequence([moveBulletAction,removeBulletAction]))
			let waitToEnableFire = SKAction.waitForDuration(0.5)

println("end of canFire")

			runAction(waitToEnableFire,completion:{
				self.canFire = true
			})
println("after canFire is set true")
		}
	}



}