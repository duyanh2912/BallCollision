//
//  ViewController.swift
//  BallCollision
//
//  Created by Duy Anh on 2/12/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

var deviceSize: CGSize {
    return UIApplication.shared.delegate!.window!!.frame.size
}
var screenWidth: CGFloat { return deviceSize.width }
var screenHeight: CGFloat { return deviceSize.height }

enum CollisionType {
    case cos,sin
}

class ViewController: UIViewController, CAAnimationDelegate {
    var circle = CAShapeLayer()
    var radius: CGFloat = 25
    var speed: CGFloat = 800
    var kCircleAnimation = "circle"
    let startingAngle = CGFloat.pi / 3.5
    var nextAngle: CGFloat!
    var nextCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circle.path = CGPath(ellipseIn: CGRect.init(x: 0, y: 0, width: radius*2, height: radius*2), transform: nil)
        circle.fillColor = try! UIColor.init(rgba_throws: "#4990E2").cgColor
        circle.position = view.center - (50,100) - (radius,radius)
        view.layer.addSublayer(circle)
        
        let param = animate(startingPoint: circle.position.add(x: radius, y: radius), angle: startingAngle)
        nextCenter = param.0
        nextAngle = param.1
    }
    
    // Return next center point and next reflecting angle
    func animate(startingPoint: CGPoint, angle: CGFloat) -> (CGPoint, CGFloat) {
        var endingPoint: CGPoint
        let converted = angle.convertedAngle
        var collsionType: CollisionType
        var endAngle: CGFloat = 0
        
        // Special cases
        if converted == 0 {
            endingPoint = CGPoint(x: screenWidth - radius, y: startingPoint.y)
            endAngle = CGFloat.pi
        }
        else if converted == CGFloat.pi {
            endingPoint = CGPoint(x: radius, y: startingPoint.y)
            endAngle = 0
        }
        else if converted == CGFloat.pi / 2 {
            endingPoint = CGPoint(x: startingPoint.x, y: screenHeight - radius)
            endAngle = CGFloat.pi * 3 / 2
        }
        else if converted == CGFloat.pi * 3 / 2 {
            endingPoint = CGPoint(x: startingPoint.x, y: radius)
            endAngle = CGFloat.pi / 2
        }
        
        // Nomal cases
        else {
            var horizontalDistance = cos(converted) > 0 ? startingPoint.distanceToRight : startingPoint.distanceToLeft
            var verticalDistance = sin(converted) > 0 ? startingPoint.distanceToBottom : startingPoint.distanceToTop
            var offSet: CGFloat = radius
            var distance: CGPoint
            collsionType = horizontalDistance * tan(converted).abs < verticalDistance ? .cos : .sin
            if collsionType == .cos {
                if cos(converted) < 0 {
                    horizontalDistance = -horizontalDistance
                    offSet = -offSet
                }
                distance = CGPoint(x: horizontalDistance, y: horizontalDistance*tan(converted)) - (offSet, offSet*tan(converted))
                    endAngle = CGFloat.pi - converted
            } else {
                if sin(converted) < 0 {
                    verticalDistance = -verticalDistance
                    offSet = -offSet
                }
                distance = CGPoint(x: verticalDistance / tan(converted), y: verticalDistance)
                distance -= (offSet/tan(converted), offSet)
                    endAngle = -converted
            }
            endingPoint = startingPoint + distance
        }
        
        // Animation
        circle.position = endingPoint.add(x: -radius, y: -radius)
        
        let anim = CABasicAnimation()
        anim.keyPath = "position"
        anim.fromValue = NSValue.init(cgPoint: startingPoint.add(x: -radius, y: -radius))
//        anim.toValue = NSValue.init(cgPoint: endingPoint.add(x: -radius, y: -radius))
        anim.duration = Double(endingPoint.subtract(startingPoint).length / speed)
        anim.delegate = self
        anim.fillMode = kCAFillModeForwards
        
        circle.add(anim, forKey: kCircleAnimation)
        return (endingPoint, endAngle)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(0)
//        circle.position = nextCenter.add(x: -radius, y: -radius)
//        CATransaction.commit()
        
        let param = animate(startingPoint: nextCenter, angle: nextAngle)
        nextCenter = param.0
        nextAngle = param.1
    }
}

extension CGFloat {
    var convertedAngle: CGFloat {
        var angle = self
        while angle > 0 {
            angle -= CGFloat.pi * 2
        }
        return angle + CGFloat.pi * 2
    }
    var abs: CGFloat {
        return self > 0 ? self : -self
    }
}
extension CGPoint {
    var distanceToLeft: CGFloat {
        return self.x
    }
    var distanceToRight: CGFloat {
        return screenWidth - self.x
    }
    var distanceToTop: CGFloat {
        return self.y
    }
    var distanceToBottom: CGFloat {
        return screenHeight - self.y
    }
}



