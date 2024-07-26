//
//  GameScene.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//
import SpriteKit

class GameScene: SKScene {
    private var player: PlayerNode!

    override func didMove(to view: SKView) {
        setupPlayer()
        setupPhysics()
    }

    func setupPlayer() {
        let playerTexture = SKTexture(imageNamed: "player") // Ensure the image is in your assets
        player = PlayerNode(texture: playerTexture)
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)
    }

    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8) // Gravity settings
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.jump() // Call the jump method on the player node
    }
    
    override func update(_ currentTime: TimeInterval) {
        // This method is called before each frame is rendered.
        // Example: Update player's position or state if needed.
        if player.position.y < frame.minY {
            player.position.y = frame.midY // Reset player position if it goes off screen
        }
    }
}
