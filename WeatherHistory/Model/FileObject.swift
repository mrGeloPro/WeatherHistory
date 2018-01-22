//
//  FileObject.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit

class FileObject: NSObject {
    
    var descriptionFile: String?
    var format: String?
    var fileUrlString: String?
    
    init(_ dictionary: Dictionary<String, Any>) {
        if let description = dictionary["description"] as? String {
            self.descriptionFile = description
        }
        if let format = dictionary["format"] as? String {
            self.format = format
        }
        if let url = dictionary["url"] as? String {
                self.fileUrlString = url
        }
    }
    
}
