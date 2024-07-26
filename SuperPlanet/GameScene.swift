//
//  GameScene.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import SpriteKit

class GameScene: SKScene {
    var player: PlayerNode!
    private var ground: GroundNode!

    override func didMove(to view: SKView) {
        setupSpaceParticales()
        setupPhysics()
        setupPlayer()
        setupGround()
    }
    
    func setupSpaceParticales() {
        if let particales = SKEmitterNode(fileNamed: "Space") {
            particales.position = CGPoint(x: 1000, y: 0)
            particales.advanceSimulationTime(60)
            particales.zPosition = -1
            addChild(particales)
        }
    }
    
    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8) // Gravity settings
    }

    func setupPlayer() {
//        player.name = "player" TODO:
        player = PlayerNode(imageNamed: "player") // Ensure the image is in your assets
        player.position = CGPoint(x: frame.minX + 120, y: frame.midY)
        player.zPosition = 1
        addChild(player)
    }
    
    func setupGround() {
        // Create the ground node using the custom GroundNode class
        ground = GroundNode(size: CGSize(width: frame.width, height: 140))
        ground.position = CGPoint(x: frame.midX, y: frame.minY)
        addChild(ground)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // This method is called before each frame is rendered.
        // Example: Update player's position or state if needed.
        if player.position.y < frame.minY {
            player.position.y = frame.midY // Reset player position if it goes off screen
        }
    }
}
