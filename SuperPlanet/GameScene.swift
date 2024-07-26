//
//  GameScene.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import SpriteKit

class GameScene: SKScene {
    var player: SKSpriteNode!

    override func didMove(to view: SKView) {
        setupPlayer()
        setupPhysics()
    }

    func setupPlayer() {
        player = SKSpriteNode(imageNamed: "player") // Replace with your player image
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.size = CGSize(width: 50, height: 50)
        addChild(player)
    }

    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8) // Set gravity
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.ground
        player.physicsBody?.collisionBitMask = PhysicsCategory.ground
    }
    
    func jump() {
        if player.physicsBody?.velocity.dy == 0 {
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200)) // Adjust impulse for jump strength
        }
    }
}
