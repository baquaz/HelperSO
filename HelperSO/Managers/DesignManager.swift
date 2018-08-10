//
//  DesignManager.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 09.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import UIKit

class DesignManager {
    //MARK: - Gradient Background
    private enum GradientDirection {
        case StraightTopToBottom
        case DiagonalTopToBottom
        case LeftToRight
    }
    
    static func addGradientBackground(on view: UIView) {
        let screenFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
        view.layer.insertSublayer(DesignManager.backgroundGradientLayer(frame: screenFrame), at: 0)
    }
    
    static private func backgroundGradientLayer(frame: CGRect) -> CAGradientLayer {
        let colors = [UIColor.lightBlue.cgColor, UIColor.strongBlue.cgColor]
        let direction: GradientDirection = .StraightTopToBottom
        
        let gradientLayer = CAGradientLayer()
        let points = setupPointsToGradient(direction: direction)
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = points.first!
        gradientLayer.endPoint = points.last!
        
        return gradientLayer
    }
    
    static private func setupPointsToGradient(direction: GradientDirection) -> [CGPoint] {
        switch direction {
        case .DiagonalTopToBottom:
            let startPoint = CGPoint(x: 0.2, y: 0.0)
            let endPoint = CGPoint(x: 0.0, y: 1)
            return [startPoint, endPoint]
        case .LeftToRight:
            let startPoint = CGPoint(x: 0, y: 0)
            let endPoint = CGPoint(x: 1, y: 0)
            return [startPoint, endPoint]
        case .StraightTopToBottom:
            let startPoint = CGPoint(x: 0, y: 0)
            let endPoint = CGPoint(x: 0, y: 1)
            return [startPoint, endPoint]
        }
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha:1)
    }
    
    class var lightBlue: UIColor {
        return UIColor(r: 240, g: 240, b: 255)
    }
    
    class var strongBlue: UIColor {
        return UIColor(r: 66, g: 150, b: 255)
    }
}
