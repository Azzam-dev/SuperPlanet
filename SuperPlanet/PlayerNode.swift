//
//  PlayerNode.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import SpriteKit

class PlayerNode: SKNode {
    private let playerSprite: SKSpriteNode

    init(texture: SKTexture?) {
        // Initialize the sprite node
        playerSprite = SKSpriteNode(texture: texture)
        super.init()
        
        // Set up the sprite node
        playerSprite.size = CGSize(width: 50, height: 50)
        playerSprite.position = CGPoint.zero // Position relative to SKNode
        playerSprite.physicsBody = SKPhysicsBody(rectangleOf: playerSprite.size)
        playerSprite.physicsBody?.categoryBitMask = PhysicsCategory.player
        playerSprite.physicsBody?.contactTestBitMask = PhysicsCategory.ground
        playerSprite.physicsBody?.collisionBitMask = PhysicsCategory.ground
        
        // Add the sprite node to the custom node
        addChild(playerSprite)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom method to handle jumping
    func jump() {
        if playerSprite.physicsBody?.velocity.dy == 0 {
            playerSprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200)) // Adjust impulse as needed
        }
    }

    // Custom method to move the player
    func move(by offset: CGPoint) {
//        position += offset
//        playerSprite.position -= offset
    }
}
