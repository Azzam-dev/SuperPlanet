//
//  GameScene.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import SpriteKit

class GameScene: SKScene {
    
    var lastUpdateTime: TimeInterval = 0
    
    var player: PlayerNode!
    private var ground: GroundNode!
    var worldMap = [[ObstacleNode]]()
    
    private var tileMapNode: SKTileMapNode!
    
    override func didMove(to view: SKView) {
        lastUpdateTime = CACurrentMediaTime()
        
        setupSpaceParticales()
        setupPhysics()
        setupPlayer()
        setupGround()
        setupWorldMap()
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
        
        let blockSize = CGSize(width: 50, height: 50)
        let basicSizeUnit = blockSize.height
        for index in 0...Int(frame.width / basicSizeUnit) + 1 {
            let obstacle = ObstacleNode(imageNamed: "BG-Green", size: blockSize, position: CGPoint(x: CGFloat(index) * basicSizeUnit, y: frame.minY + ground.groundSprite.size.height - basicSizeUnit / 2 ))
            let obstacle2 = ObstacleNode(imageNamed: "BG-Green", size: blockSize, position: CGPoint(x: CGFloat(index) * basicSizeUnit, y: frame.minY + ground.groundSprite.size.height - basicSizeUnit - (basicSizeUnit / 2) ))
            let obstacle3 = ObstacleNode(imageNamed: "BG-Green", size: blockSize, position: CGPoint(x: CGFloat(index) * basicSizeUnit, y: frame.minY + ground.groundSprite.size.height - basicSizeUnit * 2 - (basicSizeUnit / 2) ))
            addChild(obstacle)
            addChild(obstacle2)
            addChild(obstacle3)
            
        }
        
    }
    
    func setupWorldMap() {
        // Create the ground node using the custom GroundNode class
        let blockSize = CGSize(width: 50, height: 50)
        let basicSizeUnit = blockSize.height
        let frameMaxX = frame.maxX
        let groundMaxY = frame.minY + ground.groundSprite.size.height + basicSizeUnit / 2
        let imageName1 = "BG-Purple"
        let imageName2 = "BG-Blue"
        let sectionObstacles = [
            ObstacleNode(imageNamed: imageName1, size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 4, y: groundMaxY)),
            ObstacleNode(imageNamed: imageName2, size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 6, y: groundMaxY)),
            ObstacleNode(imageNamed: imageName1,size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 8, y: groundMaxY + basicSizeUnit )),
            
        ]
        
        let sectionObstacles2 = [
            ObstacleNode(imageNamed: imageName1,size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 14, y: groundMaxY)),
            ObstacleNode(imageNamed: imageName2,size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 18, y: groundMaxY + basicSizeUnit )),
            
        ].shuffled()
        
        let sectionObstacles3 = [
            ObstacleNode(imageNamed: imageName2,size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 26, y: groundMaxY)),
            ObstacleNode(imageNamed: imageName1,size: blockSize, position: CGPoint(x: frameMaxX + basicSizeUnit * 28, y: groundMaxY + basicSizeUnit * 2 )),
            
        ].shuffled()
        
        
        
        
        worldMap = [sectionObstacles, sectionObstacles2, sectionObstacles3].shuffled()
        worldMap.enumerated().forEach { index, section in
            section.forEach { obstacle in
                //                obstacle.position.x += CGFloat(Int(basicSizeUnit) * index + 1)
                addChild(obstacle)
            }
        }
    }
    
    
    fileprivate func worldMapMovement() {
        worldMap.forEach { section in
            section.forEach { obstacle in
                obstacle.position.x -= 1
                
                // Optional: Boundary check
                if obstacle.position.x < frame.minX { //TODO:
                    obstacle.position.x = frame.maxX // Wrap around
                }
            }
        }
    }
    
    func resetPlayerPosition() {
        // This method is called before each frame is rendered.
        // Example: Update player's position or state if needed.
        print("player postion: \(player.position), frame minX \(frame.minX), frame maxX \(frame.maxX), frame minY \(frame.minY), frame maxY \(frame.maxY)")
        // Check if the player is outside the screen bounds with a margin
        let margin: CGFloat = 100 // Adjust margin as needed
        if player.playerSprite.position.x + margin < frame.minX  || player.playerSprite.position.x + margin > frame.maxX  {
            // Reset player position if it goes off screen
            player.playerSprite.position = CGPoint(x: frame.midX, y: frame.midY)
            
            // Remove the existing physics body
            player.playerSprite.physicsBody = nil
            
            // Create a new physics body
            player.playerSprite.physicsBody = SKPhysicsBody(rectangleOf: player.playerSprite.size)
            player.playerSprite.physicsBody?.categoryBitMask = PhysicsCategory.player
            player.playerSprite.physicsBody?.contactTestBitMask = PhysicsCategory.ground | PhysicsCategory.obstacle | PhysicsCategory.enemy
            player.playerSprite.physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.obstacle | PhysicsCategory.enemy
            player.playerSprite.physicsBody?.affectedByGravity = true
            print("Player position reset to center and physics body reset")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Calculate the time interval since the last update
        let deltaTime = CGFloat(currentTime - lastUpdateTime)
        lastUpdateTime = currentTime
        
        
        resetPlayerPosition()
        worldMapMovement()
        
        
    }
}
