//
//  PlayerNode.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import SpriteKit

class PlayerNode: SKNode {
    private let playerSprite: SKSpriteNode
    private var originalPlayerPosition: CGPoint?

    init(imageNamed: String) {
        // Initialize the sprite node
        playerSprite = SKSpriteNode(imageNamed: imageNamed)
        super.init()
        
        // Set up the sprite node
        playerSprite.size = CGSize(width: 50, height: 50)
        playerSprite.position = CGPoint.zero // Position relative to SKNode
        playerSprite.physicsBody = SKPhysicsBody(rectangleOf: playerSprite.size)
        playerSprite.physicsBody?.categoryBitMask = PhysicsCategory.player
        playerSprite.physicsBody?.contactTestBitMask = PhysicsCategory.ground | PhysicsCategory.obstacle | PhysicsCategory.enemy
        playerSprite.physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.obstacle | PhysicsCategory.enemy
        playerSprite.physicsBody?.affectedByGravity = true
        // Add the sprite node to the custom node
        addChild(playerSprite)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom method to handle jumping
    func jump() {
        //if playerSprite.physicsBody?.velocity.dy == 0 {
        playerSprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50)) // Adjust impulse as needed
        //}
    }
    
    
    // Custom method to move the player
    func move(by offset: CGPoint) {
        playerSprite.physicsBody?.applyImpulse(CGVector(dx: offset.x, dy: offset.y)) // Adjust impulse as needed
    }
    
    func moveThenReset(by offset: CGPoint) {
        // Record the current position
        originalPlayerPosition = playerSprite.position
        
        // Apply impulse
        guard let physicsBody = playerSprite.physicsBody else {
            print("Player sprite does not have a physics body.")
            return
        }
        
        let impulse = CGVector(dx: offset.x, dy: offset.y)
        physicsBody.applyImpulse(impulse)
        
        // Add a delay before moving back
        let delay = SKAction.wait(forDuration: 1.0) // Delay duration in seconds
        let moveBackAction = SKAction.move(to: originalPlayerPosition!, duration: 1.0) // Adjust duration as needed
        
        // Run actions in sequence: delay first, then move back
        let sequence = SKAction.sequence([delay, moveBackAction])
        playerSprite.run(sequence) {
            // Reset physics body velocity when the action completes
            physicsBody.velocity = .zero
            physicsBody.angularVelocity = 0
        }
    }
}
