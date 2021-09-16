//
//  MainTabBar.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import Foundation
import UIKit

class MainTabBar: UITabBar {
    private var shapeLayer: CALayer?
    private func addShape() {
        let shapeLayer = CAShapeLayer()

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = .black
        self.tintColor = .green
        
        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0).cgPath

          let ctx = UIGraphicsGetCurrentContext()!
          ctx.addPath(clipPath)
          ctx.setFillColor(UIColor.red.cgColor)

          ctx.closePath()
          ctx.fillPath()
    }
    
    
  
}
