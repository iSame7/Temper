
//
//  PriceShapeView.swift
//  Temper
//
//  Created by Sameh Mabrouk on 19/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class PriceShapeView: UIView {
    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.complexShape()
    }
    
    func complexShape() {
        let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 29.5))
        bezierPath.addCurve(to: CGPoint(x: 11.67, y: 26.53), controlPoint1: CGPoint(x: 0.39, y: 28.75), controlPoint2: CGPoint(x: 4.46, y: 29.33))
        bezierPath.addCurve(to: CGPoint(x: 14.52, y: 25.39), controlPoint1: CGPoint(x: 12.6, y: 26.16), controlPoint2: CGPoint(x: 13.7, y: 25.74))
        bezierPath.addCurve(to: CGPoint(x: 18.18, y: 23.42), controlPoint1: CGPoint(x: 15.82, y: 24.83), controlPoint2: CGPoint(x: 17.01, y: 24.22))
        bezierPath.addCurve(to: CGPoint(x: 21.5, y: 20.79), controlPoint1: CGPoint(x: 18.95, y: 22.89), controlPoint2: CGPoint(x: 20.72, y: 21.54))
        bezierPath.addCurve(to: CGPoint(x: 27.18, y: 12.85), controlPoint1: CGPoint(x: 25.93, y: 16.54), controlPoint2: CGPoint(x: 23.72, y: 17.37))
        bezierPath.addCurve(to: CGPoint(x: 49.13, y: 0.54), controlPoint1: CGPoint(x: 37.63, y: -0.8), controlPoint2: CGPoint(x: 49.13, y: 0.54))
        bezierPath.addCurve(to: CGPoint(x: 82.58, y: 0.87), controlPoint1: CGPoint(x: 49.13, y: 0.54), controlPoint2: CGPoint(x: 70.91, y: 0.85))
        bezierPath.addCurve(to: CGPoint(x: 138.5, y: 0.86), controlPoint1: CGPoint(x: 108.66, y: 0.92), controlPoint2: CGPoint(x: 138.5, y: 0.86))
        bezierPath.addLine(to: CGPoint(x: 138.5, y: 29.46))
        bezierPath.addLine(to: CGPoint(x: 0, y: 29.5))
        color.setFill()
        bezierPath.fill()
        color.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        
        self.backgroundColor = UIColor.orange
        self.layer.mask = shapeLayer
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
