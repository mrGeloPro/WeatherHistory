//
//  WeatherHistory.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 21.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class WeatherHistory: NSObject {
    var date: Date?
    var temperatureMax: Float?
    var temperatureMin: Float?
    var days: Int?
    var rain: Float?
    var sunHours: Float?
    var sensor: String?
    var estimated: Bool?
    
    static func parser(_ string: String) -> [WeatherHistory] {
        
        var historiArray = [WeatherHistory]()
        
        var stringArray = string.components(separatedBy: "hours")
        stringArray = stringArray[1].components(separatedBy: "\n")
        for index in  1..<stringArray.count{
            // dont work /t
            let dataHistory = stringArray[index]//components(separatedBy: "\t")
            let historyDictionary = WeatherHistory.parserString(dataHistory)
            historiArray.append(WeatherHistory(historyDictionary))
        }
        return historiArray
    }
    
    static func parserDate(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-m"
        let date = dateFormatter.date(from: string)
        return date
    }
    
    static func parserString(_ string: String) -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        var dataHistory = string
        dataHistory = dataHistory.replacingOccurrences(of: "    ", with: " ")
        dataHistory = dataHistory.replacingOccurrences(of: "   ", with: " ")
        dataHistory = dataHistory.replacingOccurrences(of: "  ", with: " ")
        dataHistory = dataHistory.replacingOccurrences(of: " ", with: "\t")
        dataHistory = dataHistory.replacingOccurrences(of: "\r", with: "")
        let estimatedCharset = CharacterSet(charactersIn: "*")
        if dataHistory.rangeOfCharacter(from: estimatedCharset) != nil {
            dictionary["estimated"] = true
        } else {
            dictionary["estimated"] = false
        }
        let sensorCharset = CharacterSet(charactersIn: "#")
        if dataHistory.rangeOfCharacter(from: sensorCharset) != nil {
            dictionary["sensor"] = "Kipp & Zonen"
        } else {
            dictionary["sensor"] =  "Campbell Stokes"
        }
        dataHistory = dataHistory.replacingOccurrences(of: "*", with: "")
        dataHistory = dataHistory.replacingOccurrences(of: "#", with: "")
        
        let dataHistoryArray = dataHistory.components(separatedBy: "\t")
        dictionary["date"] = WeatherHistory.parserDate(dataHistoryArray[1] + "-" + dataHistoryArray[2])
        dictionary["temperatureMax"] = dataHistoryArray[3]
        dictionary["temperatureMin"] = dataHistoryArray[4]
        dictionary["days"] = dataHistoryArray[5]
        dictionary["rain"] = dataHistoryArray[6]
        dictionary["sunHours"] = dataHistoryArray[7]
        
        return dictionary
    }
    
    override init() {
        super.init()
    }
    
    init(_ diictionary: Dictionary<String, Any>) {
        super.init()
        if let estimated = diictionary["estimated"] as? Bool {
            self.estimated = estimated
        }
        if let sensor = diictionary["sensor"] as? String {
            self.sensor = sensor
        }
        if let date = diictionary["date"] as? Date {
            self.date = date
        }
        if let temperatureMax = diictionary["temperatureMax"] as? String {
            self.temperatureMax = Float(temperatureMax)
        }
        if let temperatureMin = diictionary["temperatureMin"] as? String {
            self.temperatureMin = Float(temperatureMin)
        }
        if let days = diictionary["days"] as? String {
            self.days = Int(days)
        }
        if let rain = diictionary["rain"] as? String {
            self.rain = Float(rain)
        }
        if let sunHours = diictionary["sunHours"] as? String {
            self.sunHours = Float(sunHours)
        }
    }
    
}
