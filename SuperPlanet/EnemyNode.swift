//
//  EnemyNode.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 21/01/1446 AH.
//

import SpriteKit

class EnemyNode: SKSpriteNode {
    
    init(size: CGSize) {
        let texture = SKTexture(imageNamed: "enemy") // Ensure you have this image in your assets
        super.init(texture: texture, color: .clear, size: size)
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player
        self.physicsBody?.collisionBitMask = PhysicsCategory.player
    }
}