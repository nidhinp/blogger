//
//  CAShapeLayer+Extensions.swift
//  Consumer
//
//  Created by Q8coders on 5/30/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    public func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}
