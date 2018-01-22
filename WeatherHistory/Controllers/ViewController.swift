//
//  ViewController.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 21.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dateArray:Array = Array<String>()
    var weatherArray = [WeatherHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        if let urlWeather = URL(string: "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt") {
            do {
                let contents = try String(contentsOf: urlWeather)
                self.weatherArray = WeatherHistory.parser(contents)
                var dateSet = Set<String>()
                for weather in weatherArray {
                    if let date = weather.date {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy"
                        let dateString = dateFormatter.string(from: date)
                        dateSet.insert(dateString)
                    }
                    
                }
                self.dateArray = Array(dateSet)
                self.dateArray.sort { (date1, date2) -> Bool in
                    if  let intDate1 = Int(date1) {
                        if let intDate2 = Int(date2) {
                            return intDate1 > intDate2
                        }
                    }
                    return false
                }
            } catch {
                // contents could not be loaded
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "history of " + dateArray[indexPath.row]
        return cell
    }
  
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as? DetailsWeatherViewController {
            let weather = self.weatherArray
            vc.weathersArray = weather.filter({ (weather) -> Bool in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy"
                let dateString = dateFormatter.string(from: weather.date!)
                    return dateString == dateArray[indexPath.row]
            })
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
