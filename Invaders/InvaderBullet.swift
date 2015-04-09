//
//  InvaderBullet.swift
//  Invaders
//
//  Created by Daniel Flax on 4/6/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit
import SpriteKit

class InvaderBullet: Bullet {

	override init(imageName: String, bulletSound:String?){
		super.init(imageName: imageName, bulletSound: bulletSound)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// Allow invaders to fire bullets
	func fireBullet(scene: SKScene){
		let bullet = InvaderBullet(imageName: "laser",bulletSound: nil)
		bullet.position.x = self.position.x
		bullet.position.y = self.position.y - self.size.height/2
		scene.addChild(bullet)
		let moveBulletAction = SKAction.moveTo(CGPoint(x:self.position.x,y: 0 - bullet.size.height), duration: 2.0)
		let removeBulletAction = SKAction.removeFromParent()
		bullet.runAction(SKAction.sequence([moveBulletAction,removeBulletAction]))
	}

}
