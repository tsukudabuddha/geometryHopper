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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        player.removeAction(forKey: "jumpSequence")
//        var dVector = CGVector.zero
//        var downVector = CGVector.zero
//        let forceValue = 125
//
//        switch player.orientation {
//        case .bottom:
//            dVector = CGVector(dx: 0, dy: forceValue)
//            downVector = CGVector(dx: 0, dy: -1 * player.frame.minY)
//        case .right:
//            dVector = CGVector(dx: forceValue * -1, dy: 0)
//            downVector = CGVector(dx: -1 * player.frame.maxX, dy: 0)
//        case .top:
//            dVector = CGVector(dx: 0, dy: forceValue * -1)
//            downVector = CGVector(dx: 0, dy: player.frame.maxY)
//        case .left:
//            dVector = CGVector(dx: forceValue, dy: 0)
//            downVector = CGVector(dx: player.frame.minX, dy: 0)
//        }
//        let jumpAction = SKAction.move(by: dVector, duration: 0.35)
//        jumpAction.timingMode = SKActionTimingMode.easeOut
//        let down = SKAction.run {
//            switch self.player.orientation {
//            case .bottom:
//                downVector = CGVector(dx: 0, dy: self.frame.minY - self.player.frame.minY)
//            case .right:
//                downVector = CGVector(dx:  self.frame.maxX - self.player.frame.maxX, dy: 0)
//            case .top:
//                downVector = CGVector(dx: 0, dy: self.frame.maxY - self.player.frame.maxY)
//            case .left:
//                downVector = CGVector(dx: self.frame.minX - self.player.frame.minX, dy: 0)
//            }
//            let down = SKAction.move(by: downVector, duration: 0.35)
//            down.timingMode = .easeIn
//            self.player.run(down)
//        }
//
//        down.timingMode = .easeIn
//        let sequence = SKAction.sequence([jumpAction, down])
//        player.run(sequence, withKey: "jumpSequence")
        let force: CGFloat = 1000000
        var impulse = CGVector.zero
        
        switch self.player.orientation {
        case .bottom:
            impulse = CGVector(dx: 0, dy: force)
        case .right:
            impulse = CGVector(dx: force * -1, dy: 0)
        case .top:
            impulse = CGVector(dx: 0, dy: force * -1)
        case .left:
            impulse = CGVector(dx: force, dy: 0)
        }
        player.physicsBody?.applyImpulse(impulse)
        
    }
    
    func playerMovement() {
        let interval: CGFloat = 3.8
        let dy = (self.frame.maxY - (player.frame.width / 2)) / interval / 60 // 60 fps
        let dx = (self.frame.maxX - (player.frame.width / 2)) / interval / 60
        var gravity = CGVector.zero

        switch player.orientation {
        case .bottom:
            
            /* Move Player */
            player.position.x += dx
            
            /* Set Gravity to normal */
            gravity = CGVector(dx: 0, dy: -9.8)
            
            if player.frame.maxX > self.frame.width - 5 {
                /* Change player orientation to work with new gravity */
                player.orientation = .right
            }
        case .right:
            
            /* Move Player */
            player.position.y += dy
            
            /* Set Gravity to right */
            gravity = CGVector(dx: 9.8, dy: 0)
            
            if player.frame.maxY > self.frame.height - 5 {
                /* Change player orientation */
                changeWalls()
            }
        
        case .top:
            /* Move Player */
            player.position.x -= dx
            
            /* Set Gravity to top */
            gravity = CGVector(dx: 0, dy: 9.8)
            
            if player.frame.minX < 5 {
                /* Change player orientation */
                changeWalls()
            }
    
        case .left:
            /* Move Player */
            player.position.y -= dy
            
            /* Set Gravity to left */
            gravity = CGVector(dx: -9.8, dy: 0)
            
            if player.frame.minY < 5 {
                /* Change player orientation */
                changeWalls()
            }
        }
        
        player.physicsBody?.applyForce(gravity)
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
//        wallTimer = Timer.scheduledTimer(timeInterval: 3.8, target: self, selector: #selector(changeWalls), userInfo: nil, repeats: true)
    }
    
    func changeWalls() {
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
