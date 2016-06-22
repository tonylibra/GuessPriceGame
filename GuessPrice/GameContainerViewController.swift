//
//  GameContainerViewController.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/20/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import UIKit

class GameContainerViewController: UIViewController {
    
    var categoryName: String?
    var datasource: [JSON]!
    var pageViewController: UIPageViewController?
    var index: Int = 0 {
        didSet {
            //when reach the last product, make the button title to done
            if self.index == datasource.count - 1 {
                self.nextButton.setTitle("Done", forState: .Normal)
            }
        }
    }
    var points = 0
    let settings = NSUserDefaults.standardUserDefaults()
    var currentProduct: ProductInfo!
    var firstLoad = false
    
    var guessedProducts = [ProductInfo]()
    
    //IBOutlet
    @IBOutlet var containerView: UIView!
    @IBOutlet var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        nextButton.enabled = false
        nextButton.setNextButton()
        self.firstLoad = true
    }
    
    override func viewDidAppear(animated: Bool) {
        if firstLoad {
            //configure pageviewcontroller
            self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
            
            let startingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
            startingViewController.delegate = self
            startingViewController.datasource = datasource[0]
            self.pageViewController?.setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
            self.addChildViewController(self.pageViewController!)
            self.containerView.addSubview(self.pageViewController!.view)
            let pageViewRect = self.containerView.bounds
            self.pageViewController!.view.frame = pageViewRect
            firstLoad = false
        }
    }

    
    func nextGameViewController() ->GameViewController {
        index += 1
        let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
        gameViewController.datasource = datasource[index]
        gameViewController.delegate = self
        return gameViewController
    }
    
    //MARK: - Actions
    @IBAction func nextButtonTapped(sender: AnyObject) {
        if index == datasource.count {
            let lastPoint = settings.integerForKey("Points")
            let title = "Congratuations"
            let message = "You just got \(points) points. Your total points is \(lastPoint + points)"
            showEndGameAlertView(title, message: message, withCancelButton: false)
        } else {
            self.pageViewController?.setViewControllers([nextGameViewController()], direction: .Forward, animated: true, completion: nil)
        }
        
        guessedProducts.append(currentProduct)
        self.nextButton.enabled = false
        
        if let product = currentProduct where product.isCorrectGuess {
            points += 1
        }
    }
    
    @IBAction func EndGameBarButtonTapped(sender: AnyObject) {
        let title = "End Game?"
        let lastPoint = settings.integerForKey("Points")
        let message = "You just got \(points) points. Your total points is \(lastPoint + points)"
        showEndGameAlertView(title, message: message, withCancelButton: true)
    }
    
    func endGameBarButtonTapped() {
        let title = "End Game?"
        let lastPoint = settings.integerForKey("Points")
        let message = "You just got \(points) points. Your total points is \(lastPoint + points)"
        showEndGameAlertView(title, message: message, withCancelButton: true)
    }
    
    
    //show the alert when user end the game
    func showEndGameAlertView(title: String, message: String, withCancelButton cancel: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let settings = NSUserDefaults.standardUserDefaults()
            let newPoints = settings.integerForKey("Points") + self.points
            settings.setInteger(newPoints, forKey: "Points")
            settings.synchronize()
            self.performSegueWithIdentifier("FinishGameSegue", sender: self)
        }
        if cancel {
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FinishGameSegue" {
            let destVC = segue.destinationViewController as! GameReviewViewController
            destVC.products = guessedProducts
        }
    }

}


extension GameContainerViewController: GameViewControllerDelegate {
    func checkProductDetailsActionWith(url: NSURL) {
        let productDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProductDetailViewController") as! ProductDetailViewController
        productDetailVC.productURL = url
        productDetailVC.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(productDetailVC, animated: true, completion: nil)
    }
    
    func updateSelectedProductInfo(product: ProductInfo) {
        self.currentProduct = product
        self.nextButton.enabled = true
    }
}








