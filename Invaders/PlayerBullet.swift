//
//  PlayerBullet.swift
//  Invaders
//
//  Created by Daniel Flax on 4/6/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerBullet: Bullet {

	override init(imageName: String, bulletSound:String?){
		super.init(imageName: imageName, bulletSound: bulletSound)

		self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
		self.physicsBody?.isDynamic = true
		self.physicsBody?.usesPreciseCollisionDetection = true
		self.physicsBody?.categoryBitMask = CollisionCategories.PlayerBullet
		self.physicsBody?.contactTestBitMask = CollisionCategories.Invader
		self.physicsBody?.collisionBitMask = 0x0
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}



}
