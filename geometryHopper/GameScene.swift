//
//  GameScene.swift
//  geometryHopper
//
//  Created by Andrew Tsukuda on 3/8/18.
//  Copyright © 2018 Andrew Tsukuda. All rights reserved.
//

import SpriteKit
import GameplayKit

enum ScreenSide {
    case bottom, right, top, left
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var player: SKShapeNode!
    
    override func didMove(to view: SKView) {
        setupScence()
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        playerMovement()
    }
    
    func playerMovement() {
        // Bottom
        player.physicsBody?.applyForce(CGVector(dx: 0, dy: -9.8))
        // Right
        player.physicsBody?.applyForce(CGVector(dx: 9.8, dy: 0))
        // Top
        player.physicsBody?.applyForce(CGVector(dx: 0, dy: 9.8))
        // Left
        player.physicsBody?.applyForce(CGVector(dx: -9.8, dy: 0))
    }
    
    func setupScence() {
        
        /* Setup Player */
        player = SKShapeNode(circleOfRadius: 20)
        player.position = CGPoint(x: 20, y: 10)
        
        /* Set up the physicsBody of the scene */
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody?.categoryBitMask = 2
        physicsBody?.contactTestBitMask = 4
        physicsBody?.collisionBitMask = 4294967295
        physicsBody?.restitution = 0.15
        physicsBody?.friction = 0
        physicsWorld.contactDelegate = self
    }
}
