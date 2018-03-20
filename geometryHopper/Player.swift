//
//  File.swift
//  geometryHopper
//
//  Created by Andrew Tsukuda on 3/9/18.
//  Copyright © 2018 Andrew Tsukuda. All rights reserved.
//

import Foundation
import SpriteKit

enum ScreenSide {
    case bottom, right, top, left
}

class Player: SKShapeNode {
    var orientation: ScreenSide = .bottom
    
    override init(){
        super.init()
        
        let circleOfRadius: CGFloat = 30
        let diameter = circleOfRadius * 2
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint(x: circleOfRadius * -1, y: circleOfRadius * -1), size: CGSize(width: diameter, height: diameter)), transform: nil)
        
        self.strokeColor = UIColor.white
        self.fillColor = UIColor.blue
        self.physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius, center: CGPoint.zero)
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass = 100
        self.physicsBody?.affectedByGravity = false
        self.run(SKAction.rotate(byAngle: 1, duration: 0.1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
