//
//  WebService.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/20/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import Foundation

enum Result {
    case Success(NSData)
    case Failure(NSError)
}

class WebService {
    static func fetchGameDataWith(categoryID catId: String, completionBlock: (Result)->Void){
        let urlStr = "http://www.wayfair.com/v/category/display?category_id=\(catId)&_format=json"
        let url = NSURL(string: urlStr)!
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.timeoutIntervalForRequest = 15
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        defaultSession.dataTaskWithURL(url) { (data, response, error) in
            if error == nil {
                completionBlock(.Success(data!))
            } else {
                completionBlock(.Failure(error!))
            }
            }.resume()
    }
}