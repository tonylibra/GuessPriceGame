//
//  ProductDetailViewController.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/21/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import UIKit
import WebKit
class ProductDetailViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!

    var productURL: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSURLRequest(URL: productURL!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBarButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    

}
