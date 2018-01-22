//
//  DetailsWeatherViewController.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class DetailsWeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weatherGraph: WeatherGraphView!
    var weathersArray: [WeatherHistory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherGraph.weathers = weathersArray!
        tableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier:InfoTableViewCell.idCell)
    }
    
}

extension DetailsWeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathersArray != nil ?  weathersArray!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.idCell, for: indexPath) as! InfoTableViewCell
        cell.configurationCell(weathersArray![indexPath.row])
        return cell
    }
    
}

extension DetailsWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InfoTableViewCell.heightCell
    }
    
}
