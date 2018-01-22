//
//  WeatherGraphView.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class WeatherGraphView: UIView {
    
    var contex = UIGraphicsGetCurrentContext()
    var weathers = [WeatherHistory]()
    var previousPointMax: CGPoint?
    var previousPointMin: CGPoint?
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.showGraph(weathers)
    }
    
    func showGraph(_ weathers: [WeatherHistory]){
        // self.contex = UIGraphicsGetCurrentContext()
        if self.previousPointMax == nil {
            self.previousPointMax = CGPoint(x: 0, y: self.frame.size.height)
        }
        if self.previousPointMin == nil {
            self.previousPointMin = CGPoint(x: 0, y: self.frame.size.height)
        }
        for weather in weathers {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm"
            let month = dateFormatter.string(from: weather.date!)
            let monthInt = Int(month)
            self.showMax(CGFloat(weather.temperatureMax!), month: CGFloat(monthInt!))
            self.showMin(CGFloat(weather.temperatureMin!), month: CGFloat(monthInt!))
            
        }
    }
    
    func showMax(_ celsius: CGFloat, month: CGFloat) {
        let yPosition = self.frame.size.height - (celsius * ScaleCelsiusView.stepPointPX)
        let xPosition = (month * ScaleMonthView.stepPointPX)
        self.contex = UIGraphicsGetCurrentContext()
        self.contex!.move(to: self.previousPointMax!)
        self.contex!.addLine(to: CGPoint(x: xPosition , y: yPosition))
        self.contex!.setLineWidth(3.0);
        self.contex!.setStrokeColor(UIColor.red.cgColor)
        self.previousPointMax = CGPoint(x: xPosition , y: yPosition)
        self.contex!.strokePath();
    }
    
    func showMin(_ celsius: CGFloat, month: CGFloat) {
        let yPosition = self.frame.size.height - (celsius * ScaleCelsiusView.stepPointPX)
        self.contex = UIGraphicsGetCurrentContext()
        let xPosition = (month * ScaleMonthView.stepPointPX)
        self.contex!.move(to: self.previousPointMin!)
        self.contex!.addLine(to: CGPoint(x: xPosition , y: yPosition))
        self.contex!.setLineWidth(3.0);
        self.contex!.setStrokeColor(UIColor.blue.cgColor)
        self.previousPointMin = CGPoint(x: xPosition , y: yPosition)
        self.contex!.strokePath();
    }
}


