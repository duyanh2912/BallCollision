//
//  File.swift
//  Hackathon
//
//  Created by Developer on 12/6/16.
//  Copyright © 2016 Developer. All rights reserved.
//
import SpriteKit
import Foundation

extension CGPoint {
    public func distance(to other: CGPoint) -> CGFloat {
        let dx = other.x - self.x
        let dy = other.y - self.y
        
        return sqrt(dx * dx + dy * dy)
    }
    
    public func subtract(_ other: CGPoint) -> CGVector {
        return CGVector(dx: self.x - other.x, dy: self.y-other.y)
    }
    
    public func subtract(x: CGFloat, y: CGFloat) -> CGVector {
        return subtract(CGPoint(x: x, y: y))
    }
    
    public func add(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    
    prefix static public func -(point: CGPoint) -> CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }
    
    static public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
    }
    
    static public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint{
        return lhs + -rhs
    }
    
    static public func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    static public func -=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    static public func +(lhs: CGPoint, rhs: (CGFloat,CGFloat)) -> CGPoint {
        return lhs + CGPoint(x: rhs.0, y: rhs.1)
    }
    
    static public func -(lhs: CGPoint, rhs: (CGFloat,CGFloat)) -> CGPoint {
        return lhs + CGPoint(x: -rhs.0, y: -rhs.1)
    }
    
    static public func +=(lhs: inout CGPoint, rhs: (CGFloat,CGFloat)) {
        lhs = lhs + rhs
    }
    
    static public func -=(lhs: inout CGPoint, rhs: (CGFloat,CGFloat)) {
        lhs = lhs - rhs
    }
}

