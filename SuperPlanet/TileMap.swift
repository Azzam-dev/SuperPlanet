//
//  TileMap.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 21/01/1446 AH.
//
import SpriteKit

class TileMap: SKNode {
    private var tileMapNode: SKTileMapNode!

    init(tileSetName: String, tileSize: CGSize, mapSize: CGSize, tileTextureName: String) {
        super.init()
        setupTileMap(tileSetName: tileSetName, tileSize: tileSize, mapSize: mapSize, tileTextureName: tileTextureName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTileMap(tileSetName: String, tileSize: CGSize, mapSize: CGSize, tileTextureName: String) {
        
        guard let tileSet = SKTileSet(named: "GroundTileSet") else {
            print("Tile set not found")
            return
        }

        tileMapNode = SKTileMapNode(tileSet: tileSet, columns: Int(mapSize.width), rows: Int(mapSize.height), tileSize: tileSize)
        tileMapNode.position = CGPoint(x: 0, y: 0) // Adjust based on your game
        tileMapNode.zPosition = -1 // Ensure the tile map is behind other game elements

        addChild(tileMapNode)

        populateTileMap(tileTextureName: tileTextureName)
    }

    private func populateTileMap(tileTextureName: String) {
        let tileTexture = SKTexture(imageNamed: tileTextureName)
        let tileSize = tileTexture.size()
        let tileDefinition = SKTileDefinition(texture: tileTexture)
        let tileGroup = SKTileGroup(tileDefinition: tileDefinition)
        let tileSet = SKTileSet(tileGroups: [tileGroup])
        tileMapNode.tileSet = tileSet

        for column in 0..<tileMapNode.numberOfColumns {
            for row in 0..<tileMapNode.numberOfRows {
                let tileGroup = SKTileGroup(tileDefinition: tileDefinition)
                tileMapNode.setTileGroup(tileGroup, forColumn: column, row: row)
            }
        }
    }
}
