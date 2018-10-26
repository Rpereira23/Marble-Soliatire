//
//  Marble.swift
//  MarbleSolitaire
//
//  Created by Raique Pereira on 10/10/18.
//  Copyright © 2018 Raique Pereira. All rights reserved.
//

import UIKit

@IBDesignable class MarbleView: UIView {
    @IBInspectable public var fillColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)    {
        didSet { setNeedsLayout() }
        
    }
    @IBInspectable public var strokeColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 0)  { didSet { setNeedsLayout() } }
    @IBInspectable public var lineWidth: CGFloat = 0     { didSet { setNeedsLayout() } }
    
    lazy private var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.size.width, bounds.size.height) - lineWidth) / 2
        shapeLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true).cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
    }
    
    

}
