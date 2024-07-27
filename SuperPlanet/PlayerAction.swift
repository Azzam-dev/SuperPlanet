//
//  PlayerAction.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 21/01/1446 AH.
//

enum ActionCardsEnum: String {
    case forward = "arrowshape.right.fill"
    case back = "arrowshape.left.fill"
    case jump = "arrowshape.up.fill"
    case attack = "hands.sparkles.fill"
//    case doubleJump = "Double Jump" // Fixed typo and assigned raw value
//    case evolve = "Evolve" // Added raw value
}

struct PlayerAction { //TODO:
    let card: ActionCardsEnum
}
