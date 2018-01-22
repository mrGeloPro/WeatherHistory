//
//  ListFilesViewController.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class ListFilesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fileArray = [FileObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.shared.loadFile(completion: { files in 
            self.fileArray = files.filter({ (file) -> Bool in
                return file.format == "TXT"
            })
            self.tableView.reloadData()
        }) { (error) in
            
        }
        tableView.register(UINib(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier:FileTableViewCell.idCell)
    }
    
}
extension ListFilesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCell.idCell, for: indexPath) as! FileTableViewCell
        cell.descLabel.text = fileArray[indexPath.row].descriptionFile
        return cell
    }
    
}

extension ListFilesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FileTableViewCell.heightCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "yersList") as? ViewController {
            vc.urlString =  fileArray[indexPath.row].fileUrlString!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
