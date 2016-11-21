//
//  Bullet.swift
//  Invaders
//
//  Created by Daniel Flax on 4/6/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit
import SpriteKit

class Bullet: SKSpriteNode {
	
	
	init(imageName: String, bulletSound: String?) {
		let texture = SKTexture(imageNamed: imageName)
		super.init(texture: texture, color: SKColor.clear, size: texture.size())
		if(bulletSound != nil){
			run(SKAction.playSoundFileNamed(bulletSound!, waitForCompletion: false))
		}
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

}
