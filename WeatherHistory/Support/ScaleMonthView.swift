//
//  ScaleMonthView.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class ScaleMonthView: UIView {
    
    var contex = UIGraphicsGetCurrentContext()
    var countScala: CGFloat = 12.0
    static var stepPointPX: CGFloat = 0.0
    var stepMonth: CGFloat = 1
    var maxMonth: CGFloat = 12
    
    override func draw(_ rect: CGRect) {
        ScaleMonthView.stepPointPX = rect.size.width /  (maxMonth * 1.1);
        for index in 0..<Int(self.countScala) {
            let positionLine = (self.stepMonth * ScaleMonthView.stepPointPX) * CGFloat(index + 1)
            self.contex = UIGraphicsGetCurrentContext()
            self.contex!.move(to: CGPoint(x: rect.size.width - positionLine + 1.0, y: 0))
            self.contex!.addLine(to: CGPoint(x: rect.size.width -  positionLine + 1.0 , y: rect.size.height / 2 ))
            self.contex!.setLineWidth(3.0);
            self.contex!.setStrokeColor(UIColor.black.cgColor)
            let title = String(describing: Int((self.maxMonth * 1.1) - (self.stepMonth * CGFloat(index + 1))))
            title.draw(at: CGPoint(x: rect.size.width - positionLine + 1.0, y: rect.size.height / 2), withAttributes: [:])
            self.contex!.strokePath();
            
        }
    }
    
}
