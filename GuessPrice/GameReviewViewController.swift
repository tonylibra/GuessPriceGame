//
//  GameReviewViewController.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/21/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import UIKit

class GameReviewViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var doneButton: UIButton!
    
    var products: [ProductInfo]!
    
    @IBOutlet var summaryLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.backgroundColor = UIColor.purple()
        doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.hidden = true
        
        let totalScore = NSUserDefaults.standardUserDefaults().integerForKey("Points")
        summaryLabel.text = "You total score is \(totalScore)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension GameReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.productName
        cell.detailTextLabel?.text = String(product.salePrice)
        
        if product.isCorrectGuess {
            cell.backgroundColor = UIColor.greenColor()
        } else if product.guessPrice > product.salePrice {
            cell.backgroundColor = UIColor.purple()
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.detailTextLabel?.textColor = UIColor.whiteColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProductDetailViewController") as! ProductDetailViewController
        productDetailVC.productURL = products[indexPath.row].productUrl
        productDetailVC.modalTransitionStyle = .FlipHorizontal
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.presentViewController(productDetailVC, animated: true, completion: nil)
    }
}












