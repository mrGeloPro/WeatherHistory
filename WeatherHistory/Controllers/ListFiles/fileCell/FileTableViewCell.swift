//
//  FileTableViewCell.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 23.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class FileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    
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
    
}
