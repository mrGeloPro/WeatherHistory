//
//  APIClient.swift
//  WeatherHistory
//
//  Created by Oleg Halasa on 22.01.18.
//  Copyright © 2018 Oleh Hulovatyi. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire

final class APIClient {
    static let shared = APIClient()
    
    let decoder: JSONDecoder
    var sessionManager: SessionManager?
    
    private init(){
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func loadFile(completion:@escaping (([FileObject])->()), alertError:@escaping ((_ error: NSError)->())){
        let url = "https://data.gov.uk/api/3/action/package_show?id=historic-monthly-meteorological-station-data"
        
        self.sessionManager?.request(url).responseJSON(completionHandler: { (response: DataResponse) in
            print(response)
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    do {
                        var files = [FileObject]()
                        if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? Dictionary<String,Any> {
                            
                            if let result = json["result"] as? Dictionary<String,Any> {
                                if let resources = result["resources"] as? [Dictionary<String,Any>] {
                                    for fileDictionary in resources {
                                        files.append(FileObject(fileDictionary))
                                    }
                                }
                            }
                        }
                        completion(files)
                    } catch {
                        
                    }
                }else{
                    alertError(NSError(domain: "Invalid data", code: 1, userInfo: ["Erorr":"Invalid data"]))
                }
            case .failure(_):
                alertError(NSError(domain: "Invalid data", code: 1, userInfo: ["Erorr":"Invalid data"]))
            }
        })
    }
    
}
