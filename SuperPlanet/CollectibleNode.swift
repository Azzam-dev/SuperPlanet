//
//  CollectibleNode.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 21/01/1446 AH.
//

import SpriteKit

class CollectibleNode: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "collectible") // Ensure you have this image in your assets
        super.init(texture: texture, color: .clear, size: CGSize(width: 50, height: 50))
        self.position = position
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.collectible
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
    }
}
