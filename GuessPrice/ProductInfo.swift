//
//  ProductInfo.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/21/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import Foundation

struct ProductInfo {
    var imageUrl: NSURL
    var salePrice: Double
    var manufacturerName: String
    var productName: String
    var productUrl: NSURL
    
    var guessPrice: Double?
    
    var isCorrectGuess: Bool {
        get {
            guard let guessPrice = guessPrice else { return false }
            
            return guessPrice == salePrice
        }
    }
    
    init(imageUrl: NSURL, salePrice: Double, manufacturerName: String, productName: String, productUrl: NSURL) {
        self.imageUrl = imageUrl
        self.salePrice = salePrice
        self.manufacturerName = manufacturerName
        self.productName = productName
        self.productUrl = productUrl
    }
}