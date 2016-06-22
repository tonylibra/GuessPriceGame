//
//  StartGameViewController.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/20/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {
    
    let categories = ["Leather sofas", "Grandfather clocks", "Grills", "Kitchen Blenders", "MIX"]
    
    
    @IBOutlet var greetingTextView: UITextView!
    @IBOutlet var catePickerView: UIPickerView!
    @IBOutlet var startButton: UIButton!
    
    let greetingHTMLString: String = "<html><head><title></title></head><body><h2 style=\"text-align: center;\">Guess Price</h2><p><span style=\"font-size:20px;\">small, fun game app where users can guess the price of real Wayfair products and score points for each correct guess.</span></p><p><span style=\"font-size:18px;\">Instruction</span></p><ul><li><span style=\"font-size:18px;\">Click <strong>Start</strong>&nbsp;to start a new game</span></li><li><span style=\"font-size:18px;\">Click the <strong>Price Tag</strong> and click <strong>Next</strong> Button to next product</span></li><li><span style=\"font-size:18px;\">Click <strong>End Game</strong> to quit current game</span></li><li><span style=\"font-size:18px;\">In the Game Review, <span style=\"background-color:#00FF00;\">Green</span> line means correct answer, <span style=\"color:#FFFFFF;\"><span style=\"background-color:#800080;\">Purple</span></span> line means the actual price in lower than the price in your mind</span></li><li><span style=\"font-size:18px;\">Click the cell can access the Product on the Wayfair website</span></li></ul><p><span style=\"font-size:18px;\"><strong>Enjoy The Game!!</strong></span></p></body></html>"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingTextView.attributedText = greetingHTMLString.html2AttributedString
        
        startButton.backgroundColor = UIColor.purple()
        startButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        catePickerView.dataSource = self
        catePickerView.delegate = self
        catePickerView.showsSelectionIndicator = true
        
    }
    
    @IBAction func startButtonTapped(sender: AnyObject) {
        let cateIndex = catePickerView.selectedRowInComponent(0)
        let cateName = categories[cateIndex]
        
        if cateName == "MIX" {
            self.fetchMixGameData()
        } else {
            let cate = categoriesID[cateName]!
            
            WebService.fetchGameDataWith(categoryID: cate) { (result) in
                switch result {
                case .Success(let data):
                    let jsonData = JSON(data: data)["product_collection"].arrayValue
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.fetchDataSuccessAction(jsonData)
                    })
                case .Failure(let error):
                    print("\(error)")
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        let alertController = UIAlertController(title: "Connection Error", message: "Cannot fetch data from server", preferredStyle: .Alert)
                        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertController.addAction(alertAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                }
            }
        }
    }
    
    ///present the `GameContainerViewController` when successful get the json back
    func fetchDataSuccessAction(data: [JSON]) {
        let navigateVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameContainerNavigationController") as! UINavigationController
        let containerVC = navigateVC.topViewController as! GameContainerViewController
        containerVC.datasource = data
        navigateVC.modalTransitionStyle = .CoverVertical
        
        self.presentViewController(navigateVC, animated: true, completion: nil)
    }
    
    ///get data in all categories, and shuffle the list
    func fetchMixGameData() {
        let gameDataGroup = dispatch_group_create()
        var mixJson = [JSON]()
        for value in categories {
            let catId = categoriesID[value]!
            dispatch_group_enter(gameDataGroup)
            WebService.fetchGameDataWith(categoryID: catId, completionBlock: { (result) in
                switch result {
                case .Success(let data):
                    let tmpJson = JSON(data: data)["product_collection"].arrayValue
                    mixJson.appendContentsOf(tmpJson)
                case .Failure(let error):
                    print("fetch data error, \(error)")
                }
                
                dispatch_group_leave(gameDataGroup)
            })
        }
        
        dispatch_group_notify(gameDataGroup, dispatch_get_main_queue()) {
            mixJson.shuffle()
            self.fetchDataSuccessAction(mixJson)
        }
    }
    
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension StartGameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let keyName = categories[row]
        return keyName
    }
}












