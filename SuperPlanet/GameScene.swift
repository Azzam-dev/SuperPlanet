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
    private var Obstacle1: ObstacleNode!
    
    private var tileMapNode: SKTileMapNode!
    
    override func didMove(to view: SKView) {
        setupSpaceParticales()
        setupPhysics()
        setupPlayer()
        setupGround()
        setupSectionObstacles()
        setupTileMap()
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
    
    func setupSectionObstacles() {
        // Create the ground node using the custom GroundNode class
        let blockSize = CGSize(width: 50, height: 50)
        let basicSizeUnit = blockSize.height
        let frameMaxX = frame.maxX
        let groundMaxY = frame.minY + ground.groundSprite.size.height + basicSizeUnit / 2
        let obstacleSlideAction = SKAction.move(to: CGPoint(x: -basicSizeUnit, y: groundMaxY), duration: 2.0)
        let sectionObstacles = [
            ObstacleNode(size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 4, y: groundMaxY)),
            ObstacleNode(size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 6, y: groundMaxY)),
            ObstacleNode(size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 8, y: groundMaxY + basicSizeUnit )),
            
        ]
        sectionObstacles.forEach { obstacle in
            obstacle.run(obstacleSlideAction)
            addChild(obstacle)
        }
    }
    
    func setupTileMap() {
        // Initialize and add the TileMap node
        let tileSize = CGSize(width: 64, height: 64) // Use your tile dimensions here
        let mapSize = CGSize(width: 20, height: 15) // Adjust based on your map size
        let tileMap = TileMap(tileSetName: "GroundTileSet", tileSize: tileSize, mapSize: mapSize, tileTextureName: "BG-Green")
        tileMap.position = CGPoint(x: frame.midX - (tileMap.frame.size.width / 2), y: frame.midY - (tileMap.frame.size.height / 2))
        addChild(tileMap)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // This method is called before each frame is rendered.
        // Example: Update player's position or state if needed.
        if player.position.y < frame.minY {
            player.position.y = frame.midY // Reset player position if it goes off screen
        }
    }
}
