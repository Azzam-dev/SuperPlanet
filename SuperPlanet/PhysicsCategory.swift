//
//  PhysicsCategory.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let player: UInt32 = 0x1 << 0      // 0b0001
    static let ground: UInt32 = 0x1 << 1      // 0b0010
    static let obstacle: UInt32 = 0x1 << 2    // 0b0100
    static let enemy: UInt32 = 0x1 << 3       // 0b1000
    static let collectible: UInt32 = 0x1 << 4 // 0b0001_0000
}
