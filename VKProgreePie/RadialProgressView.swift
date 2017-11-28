//
//  RadialProgressView.swift
//  VKProgreePie
//
//  Created by Vamshi Krishna on 28/11/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RadialProgressView: UIView {
    
    var backgroundLayer:CAShapeLayer!
    @IBInspectable var backgroundLayerColor:UIColor = UIColor.darkGray {
        didSet {updateLayerProperties()}
    }
    
    var backgroundImageLayer:CALayer!
    @IBInspectable var backgroundImage:UIImage? {
        didSet {updateLayerProperties()}
    }
    
    
    var ringLayer:CAShapeLayer!
    @IBInspectable var ringThickness:CGFloat = 2
    @IBInspectable var ringColor:UIColor = UIColor.blue
    @IBInspectable var ringProgress:CGFloat = 0.75 {
        didSet {updateLayerProperties()}
    }
    
    var percentageLayer:CATextLayer!
    @IBInspectable var showPercentage:Bool = true {
        didSet {updateLayerProperties()}
    }
    @IBInspectable var showBackgroundImage:Bool = true {
        didSet {updateLayerProperties()}
    }
    @IBInspectable var percentagePosition:CGFloat = 100 {
        didSet{updateLayerProperties()}
    }
    @IBInspectable var percentageColor:UIColor = UIColor.white {
        didSet {updateLayerProperties()}
    }
    
    var lineWidth:CGFloat = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createChart()
    }
    
    func createChart() {
        layoutBackgroundLayer()
        layoutBackgoundImageLayer()
        createPie()
        updateLayerProperties()
    }
    
    
    func layoutBackgroundLayer () {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            layer.addSublayer(backgroundLayer)
            
            let rectangle = bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
            let path = UIBezierPath(ovalIn: rectangle)
            
            backgroundLayer.path = path.cgPath
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
            backgroundLayer.lineWidth = lineWidth
            
            backgroundLayer.frame = layer.bounds
            
        }
    }
    
    
    func layoutBackgoundImageLayer(){
        if backgroundImageLayer == nil {
            let imageMask = CAShapeLayer()
            let inset = lineWidth + 3
            let insetBounds = self.bounds.insetBy(dx: inset, dy: inset)
            let maskPath = UIBezierPath(ovalIn: insetBounds)
            imageMask.path = maskPath.cgPath
            imageMask.fillColor = UIColor.black.cgColor
            imageMask.frame = self.bounds
            
            backgroundImageLayer = CAShapeLayer()
            backgroundImageLayer.mask = imageMask
            backgroundImageLayer.frame = self.bounds
            backgroundImageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(backgroundImageLayer)
            
        }
    }
    
    func createPie(){
        if ringProgress == 0 {
            if ringLayer != nil {
                ringLayer.strokeEnd = 0
            }
        }
        
        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            layer.addSublayer(ringLayer)
            let inset = ringThickness / 2
            let rectangle = bounds.insetBy(dx: inset, dy: inset)
            let path = UIBezierPath(ovalIn: rectangle)
            ringLayer.transform = CATransform3DMakeRotation(CGFloat(-(M_PI_2)), 0, 0, 1)
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.path = path.cgPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = ringThickness
            ringLayer.strokeStart = 0
            
        }
        
        
        ringLayer.strokeEnd = ringProgress / 100
        ringLayer.frame = layer.bounds
        
        if percentageLayer == nil {
            percentageLayer = CATextLayer()
            layer.addSublayer(percentageLayer)
            
            
            percentageLayer.font = UIFont(name: "HelveticaNeue-Light", size: 80)
            percentageLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: percentageLayer.fontSize + 10)
            percentageLayer.position = CGPoint(x: bounds.midX, y: percentagePosition)
            percentageLayer.string = "\(Int(ringProgress))%"
            percentageLayer.alignmentMode = kCAAlignmentCenter
            percentageLayer.foregroundColor = percentageColor.cgColor
            percentageLayer.contentsScale = UIScreen.main.scale
            
        }
    }
    
    
    func updateLayerProperties() {
        if backgroundLayer != nil {
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
        }
        
        if backgroundImageLayer != nil {
            if showBackgroundImage{
                backgroundImageLayer.opacity = 1
                if let image = backgroundImage {
                    backgroundImageLayer.contents = image.cgImage
                }
            } else{
                backgroundImageLayer.opacity = 0
            }
            
            
        }
        
        if ringLayer != nil {
            ringLayer.strokeEnd = ringProgress / 100
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.lineWidth = ringThickness
        }
        
        if percentageLayer != nil {
            if showPercentage {
                percentageLayer.opacity = 1
                percentageLayer.string = "\(Int(ringProgress))%"
                percentageLayer.position = CGPoint(x: bounds.midX, y: percentagePosition)
                percentageLayer.foregroundColor = percentageColor.cgColor
            }else{
                percentageLayer.opacity = 0
            }
        }
    }
}
