//
//  GameScene.swift
//  geometryHopper
//
//  Created by Andrew Tsukuda on 3/8/18.
//  Copyright © 2018 Andrew Tsukuda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var player: Player!
    private var wallTimer: Timer!
    
    override func didMove(to view: SKView) {
        setupScence()
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        playerMovement()
    }
    
    func playerMovement() {
        let interval: CGFloat = 3.8
        let dy = (self.frame.maxY - player.frame.width) / interval / 60 // 60 fps
        let dx = (self.frame.maxX - player.frame.width) / interval / 60
        
        switch player.orientation {
        case .bottom:
            player.position.x += dx
            player.physicsBody?.applyForce(CGVector(dx: 0, dy: -9.8))
        case .right:
            player.position.y += dy
            player.physicsBody?.applyForce(CGVector(dx: 9.8, dy: 0))
        case .top:
            player.position.x -= dx
            player.physicsBody?.applyForce(CGVector(dx: 0, dy: 9.8))
        case .left:
            player.position.y -= dy
            player.physicsBody?.applyForce(CGVector(dx: -9.8, dy: 0))
        }
        
    }
    
    func setupScence() {
        
        /* Setup Player */
        player = Player()
        player.position = CGPoint(x: 20, y: 10)
        addChild(player)
        
        /* Set up the physicsBody of the scene */
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody?.categoryBitMask = 2
        physicsBody?.contactTestBitMask = 4
        physicsBody?.collisionBitMask = 4294967295
        physicsBody?.restitution = 0.15
        physicsBody?.friction = 0
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        /* Setup Timer to change 'gravity' */
        wallTimer = Timer.scheduledTimer(timeInterval: 3.8, target: self, selector: #selector(changeWalls), userInfo: nil, repeats: true)
    }
    
    @objc func changeWalls() {
        switch player.orientation {
        case .bottom:
            player.orientation = .right
        case .right:
            player.orientation = .top
        case .top:
            player.orientation = .left
        case .left:
            player.orientation = .bottom
        }
    }
}
