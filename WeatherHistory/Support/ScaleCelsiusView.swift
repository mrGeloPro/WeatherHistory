//
//  ScaleCelsiusView.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class ScaleCelsiusView: UIView {
    var contex = UIGraphicsGetCurrentContext()
    var countScala: CGFloat = 10.0
    static var stepPointPX: CGFloat = 0.0
    var stepCelsius: CGFloat = 10.0
    var maxCelsius: CGFloat = 100
    
    override func draw(_ rect: CGRect) {
        
        ScaleCelsiusView.stepPointPX = rect.size.height /  (maxCelsius * 1.1);
        for index in 0..<Int(self.countScala) {
            let positionLine = (self.stepCelsius * ScaleCelsiusView.stepPointPX) * CGFloat(index + 1)
            self.contex = UIGraphicsGetCurrentContext()
            self.contex!.move(to: CGPoint(x: rect.size.width / 2, y: positionLine + 1.0))
            self.contex!.addLine(to: CGPoint(x: rect.size.width , y: positionLine + 1.0))
            self.contex!.setLineWidth(3.0);
            self.contex!.setStrokeColor(UIColor.black.cgColor)
            let title = String(describing: Int((maxCelsius * 1.1) - (stepCelsius * CGFloat(index + 1)))) + "°"
            title.draw(at: CGPoint(x: 0, y: positionLine + 1.0), withAttributes: [:])
            self.contex!.strokePath();
            
        }
    }
    
    
}
