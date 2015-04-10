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
println("PlayerBullet init with values imageName:\(imageName) and bulletSound:\(bulletSound)")
		super.init(imageName: imageName, bulletSound: bulletSound)
println("PlayerBullet init - end")
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}



}