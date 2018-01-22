//
//  InfoTableViewCell.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var monthLable: UILabel!
    @IBOutlet weak var tMaxLabel: UILabel!
    @IBOutlet weak var tMinLabel: UILabel!
    @IBOutlet weak var deysLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var sunLabel: UILabel!
    
    static let idCell = "infoCell"
    static let heightCell:CGFloat = 76
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        innerView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        innerView.layer.borderWidth = 0.5
        
        let margin:CGFloat = 40.0
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: innerView.frame.width - margin, height: innerView.frame.height))
        
        innerView.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        innerView.layer.shadowOffset = CGSize(width: margin / 2.0, height: 5)  //Here you control x and y
        innerView.layer.shadowOpacity = 0.5
        innerView.layer.shadowRadius = 5.0 //Here your control your blur
        innerView.layer.masksToBounds =  false
        innerView.layer.shadowPath = shadowPath.cgPath
    }
    
    func configurationCell(_ weather: WeatherHistory) {
        if let date = weather.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm"
            self.monthLable.text = dateFormatter.string(from: date)
        }
        if let tMax = weather.temperatureMax {
            self.tMaxLabel.text = String(tMax)
        }
        if let tMin = weather.temperatureMin {
            self.tMinLabel.text = String(tMin)
        }
        if let deys = weather.days {
            self.deysLabel.text = String(deys)
        }
        if let rain = weather.rain {
            self.rainLabel.text = String(rain)
        }
        if let sun = weather.sunHours {
            self.sunLabel.text = String(sun)
        }
    }
    
}
