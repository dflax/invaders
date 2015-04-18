//
//  GameScene.swift
//  Invaders
//
//  Created by Daniel Flax on 3/30/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import SpriteKit
import CoreMotion

var invaderNum = 1

struct CollisionCategories{
	static let Invader:       UInt32 = 0x1 << 0
	static let Player:        UInt32 = 0x1 << 1
	static let InvaderBullet: UInt32 = 0x1 << 2
	static let PlayerBullet:  UInt32 = 0x1 << 3
	static let EdgeBody:      UInt32 = 0x1 << 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {

	let rowsOfInvaders = 4
	var invaderSpeed = 2
	let leftBounds = CGFloat(30)
	var rightBounds = CGFloat(0)
	var invadersWhoCanFire:[Invader] = [Invader]()

	let player:Player = Player()
	let maxLevels = 3

	// For core motion - to move player with the accelerometer
	let motionManager: CMMotionManager = CMMotionManager()
	var accelerationX: CGFloat = 0.0

	override func didMoveToView(view: SKView) {
		self.physicsWorld.gravity=CGVectorMake(0, 0)
		self.physicsWorld.contactDelegate = self
		self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
		self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody

		backgroundColor = SKColor.blackColor()
		rightBounds = self.size.width - 30
		setupInvaders()
		setupPlayer()
		invokeInvaderFire()
		setupAccelerometer()

		// Set up the background star field - using SpriteKit Particle (rain)
		backgroundColor = SKColor.blackColor()
		let starField = SKEmitterNode(fileNamed: "StarField")
		starField.position = CGPointMake(size.width/2,size.height/2)
		starField.zPosition = -1000
		addChild(starField)
	}

	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

		/* Called when a touch begins */
		for touch: AnyObject in touches {
			player.fireBullet(self)
		}
	}

	// Update runs each SK cycle
	// handles moving the invaders around the screen
	override func update(currentTime: CFTimeInterval) {
		moveInvaders()
	}

	func setupInvaders(){
		var invaderRow = 0;
		var invaderColumn = 0;
		let numberOfInvaders = invaderNum * 2 + 1
		for var i = 1; i <= rowsOfInvaders; i++ {
			invaderRow = i
			for var j = 1; j <= numberOfInvaders; j++ {
				invaderColumn = j
				let tempInvader:Invader = Invader()
				let invaderHalfWidth:CGFloat = tempInvader.size.width/2
				let xPositionStart:CGFloat = size.width/2 - invaderHalfWidth - (CGFloat(invaderNum) * tempInvader.size.width) + CGFloat(10)
				tempInvader.position = CGPoint(x:xPositionStart + ((tempInvader.size.width+CGFloat(10))*(CGFloat(j-1))), y:CGFloat(self.size.height - CGFloat(i) * 46))
				tempInvader.invaderRow = invaderRow
				tempInvader.invaderColumn = invaderColumn
				addChild(tempInvader)
				if(i == rowsOfInvaders){
					invadersWhoCanFire.append(tempInvader)
				}
			}
		}
	}

	func setupPlayer(){
		player.position = CGPoint(x:CGRectGetMidX(self.frame), y:player.size.height/2 + 10)
		addChild(player)
	}

	// Move the invaders around the screen
	func moveInvaders(){
		var changeDirection = false
		enumerateChildNodesWithName("invader") { node, stop in
			let invader = node as! SKSpriteNode
			let invaderHalfWidth = invader.size.width/2
			invader.position.x -= CGFloat(self.invaderSpeed)
			if(invader.position.x > self.rightBounds - invaderHalfWidth || invader.position.x < self.leftBounds + invaderHalfWidth){
				changeDirection = true
			}
		}

		if(changeDirection == true){
			self.invaderSpeed *= -1
			self.enumerateChildNodesWithName("invader") { node, stop in
				let invader = node as! SKSpriteNode
				invader.position.y -= CGFloat(46)
			}
			changeDirection = false
		}
	}

	// Invoke the invader fire bullet sequence
	func invokeInvaderFire(){
		let fireBullet = SKAction.runBlock(){
			self.fireInvaderBullet()
		}

		let waitToFireInvaderBullet = SKAction.waitForDuration(1.5)
		let invaderFire = SKAction.sequence([fireBullet,waitToFireInvaderBullet])
		let repeatForeverAction = SKAction.repeatActionForever(invaderFire)
		runAction(repeatForeverAction)
	}

	// Fire an invader bullet
	func fireInvaderBullet() {
		if (invadersWhoCanFire.isEmpty) {
			invaderNum += 1
			levelComplete()
		} else {
			let randomInvader = invadersWhoCanFire.randomElement()
			randomInvader.fireBullet(self)
		}
	}

	// SKPhysicsContactDelegate - to handle collisions between objects
	func didBeginContact(contact: SKPhysicsContact) {

		var firstBody: SKPhysicsBody
		var secondBody: SKPhysicsBody
		if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		} else {
			firstBody = contact.bodyB
			secondBody = contact.bodyA
		}

		if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
			(secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)){
				NSLog("Invader and Player Bullet Conatact")
		}

		if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
			(secondBody.categoryBitMask & CollisionCategories.InvaderBullet != 0)) {
				NSLog("Player and Invader Bullet Contact")
				player.die()
		}

		if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
			(secondBody.categoryBitMask & CollisionCategories.Player != 0)) {
				NSLog("Invader and Player Collision Contact")
				player.kill()
		}

		if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
			(secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)){
				if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
					return
				}

				let invadersPerRow = invaderNum * 2 + 1
				let theInvader = firstBody.node as! Invader
				let newInvaderRow = theInvader.invaderRow - 1
				let newInvaderColumn = theInvader.invaderColumn
				if (newInvaderRow >= 1) {
					self.enumerateChildNodesWithName("invader") { node, stop in
						let invader = node as! Invader
						if invader.invaderRow == newInvaderRow && invader.invaderColumn == newInvaderColumn {
							self.invadersWhoCanFire.append(invader)
							stop.memory = true
						}
					}
				}

				let invaderIndex = findIndex(invadersWhoCanFire, valueToFind: firstBody.node as! Invader)
				if (invaderIndex != nil) {
					invadersWhoCanFire.removeAtIndex(invaderIndex!)
				}
				theInvader.removeFromParent()
				secondBody.node?.removeFromParent()
		}
	}

	// findIndex method to assist in locating an object in an array - I believe we can now do this with indexOfObject()
	func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
		for (index, value) in enumerate(array) {
			if value == valueToFind {
				return index
			}
		}
		return nil
	}

	// MARK: - Level Methods
	func levelComplete() {
		if (invaderNum <= maxLevels) {
			let levelCompleteScene = LevelCompleteScene(size: size)
			levelCompleteScene.scaleMode = scaleMode
			let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
			view?.presentScene(levelCompleteScene,transition: transitionType)
		} else {
			invaderNum = 1
			newGame()
		}
	}

	// New Game method
	func newGame() {
		let gameOverScene = StartGameScene(size: size)
		gameOverScene.scaleMode = scaleMode
		let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
		view?.presentScene(gameOverScene,transition: transitionType)
	}

	// MARK: - Core Motion methods to manage accelerometer
	func setupAccelerometer() {
		motionManager.accelerometerUpdateInterval = 0.2
		motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
			(accelerometerData: CMAccelerometerData!, error: NSError!) in
			let acceleration = accelerometerData.acceleration
			self.accelerationX = CGFloat(acceleration.x)
		})
	}

	// Not part of core motion - part of SpriteKit
	// Use the accelerometer data to move the player via SpriteKit movement
	override func didSimulatePhysics() {
		player.physicsBody?.velocity = CGVector(dx: accelerationX * 600, dy: 0)
	}

}

