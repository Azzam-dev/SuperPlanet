//
//  GroundNode.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 21/01/1446 AH.
//

import SpriteKit

class GroundNode: SKNode {
    let groundSprite: SKSpriteNode

    init(size: CGSize) {
        groundSprite = SKSpriteNode(color: .brown, size: size)
        super.init()

        // Position the sprite within the node
        groundSprite.position = CGPoint(x: 0, y: size.height / 2)

        // Set up the physics body
        groundSprite.physicsBody = SKPhysicsBody(rectangleOf: groundSprite.size)
        groundSprite.physicsBody?.isDynamic = false // Ground should not move
        groundSprite.physicsBody?.categoryBitMask = PhysicsCategory.ground
        groundSprite.physicsBody?.contactTestBitMask = PhysicsCategory.player
        groundSprite.physicsBody?.collisionBitMask = PhysicsCategory.player

        addChild(groundSprite)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
