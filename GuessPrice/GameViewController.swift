//
//  GameViewController.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/20/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import UIKit

protocol GameViewControllerDelegate: class {
    func checkProductDetailsActionWith(url: NSURL)
    func updateSelectedProductInfo(product: ProductInfo)
    
}

class GameViewController: UIViewController {
    
    var datasource: JSON!
    var productInfo: ProductInfo!  
    var priceArray: [Double]!
    
    weak var delegate: GameViewControllerDelegate!
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var manufactureNameLabel: UILabel!
    @IBOutlet var priceButtons: [UIButton]!
    @IBOutlet var searchProductButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //configure product info
        let imageUrl = NSURL(string: datasource["image_url"].stringValue)!
        let salePrice = datasource["sale_price"].doubleValue
        let manufacturerName = datasource["manufacturer_name"].stringValue
        let productName = datasource["name"].stringValue
        let productUrl = NSURL(string: datasource["product_url"].stringValue)!
        
        productInfo = ProductInfo(imageUrl: imageUrl, salePrice: salePrice, manufacturerName: manufacturerName, productName: productName, productUrl: productUrl)
        
        priceArray = generatePriceChoices()
        
        for button in priceButtons.enumerate() {
            button.element.setTitle(String(priceArray[button.index]), forState: .Normal)
            button.element.setPriceTagButton()
        }
        
        searchProductButton.layer.borderWidth = 1.0
        searchProductButton.layer.borderColor = UIColor.purple().CGColor
        
        self.productImageView.setProductImageProperty()
        self.productNameLabel.text = productName
        self.manufactureNameLabel.text = "From: \(productInfo.manufacturerName)"
        loadProductImage()
    }
    
    
    
    func generatePriceChoices() -> [Double] {
        let priceArray = Array(count: 4, repeatedValue: productInfo.salePrice)
        
        var newPrices = priceArray.map { (price) -> Double in
            let num = Double(arc4random_uniform(200))
            let discount = Double((num - 100) / 100.0)
            return (price * (1 + discount)).roundToPlaces(2)
        }
        
        let rightIndex = Int(arc4random_uniform(4))
        newPrices[rightIndex] = productInfo.salePrice
        return newPrices
    }
    
    @IBAction func priceButtonTapped(sender: UIButton) {
        let index = priceButtons.indexOf(sender)!
        productInfo.guessPrice = priceArray[index]
        delegate.updateSelectedProductInfo(productInfo)
        
    }
    
    
    @IBAction func searchProductButtonTapped(sender: AnyObject) {
        delegate.checkProductDetailsActionWith(productInfo.productUrl)
    }
    
    
    func loadProductImage() {
        NSURLSession.sharedSession().dataTaskWithURL(productInfo.imageUrl) { (data, response, error) in
            if error == nil {
                let image = UIImage(data: data!)
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.productImageView.image = image
                })
            }
        }.resume()
    }

}