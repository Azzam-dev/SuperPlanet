//
//  MainMenu.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 21/01/1446 AH.
//


import SpriteKit

class MainMenu: SKScene {

    override func didMove(to view: SKView) {
        setupSpaceParticales()
    }
    
    func setupSpaceParticales() {
        if let particales = SKEmitterNode(fileNamed: "Space") {
            particales.position = CGPoint(x: 1000, y: 0)
            particales.advanceSimulationTime(60)
            particales.zPosition = -1
            addChild(particales)
        }
    }
    
}
