        //
//  Utils.swift
//  GuessPrice
//
//  Created by Yang, Yusheng on 6/20/16.
//  Copyright © 2016 yusheng. All rights reserved.
//

import UIKit

        extension Array {
            mutating func shuffle() {
                for i in 0 ..< (count - 1) {
                    let j = Int(arc4random_uniform(UInt32(count - i))) + i
                    guard i != j else { continue }
                    swap(&self[i], &self[j])
                }
            }
        }
        
        
        extension Double {
            /// Rounds the double to decimal places value
            func roundToPlaces(places:Int) -> Double {
                let divisor = pow(10.0, Double(places))
                return round(self * divisor) / divisor
            }
        }
        
        let categoriesID = ["Leather sofas": "492745",
                            "Grandfather clocks": "417057",
                            "Grills": "529600",
                            "Kitchen Blenders": "419247",
                            "MIX": ""]
        
        extension UIColor {
            static func purple() ->UIColor {
                return UIColor(red: 0.349, green: 0.133, blue: 0.282, alpha: 1.00)
            }
        }
        
        extension UIButton {
            func setPriceTagButton() {
                self.backgroundColor = UIColor.purple()
                self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
            
            func setNextButton() {
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.lightGrayColor().CGColor
                self.titleLabel?.font = UIFont.boldSystemFontOfSize(25)
                self.setTitleColor(UIColor.lightGrayColor(), forState: .Disabled)
                self.setTitleColor(UIColor.purple(), forState: .Normal)
            }
        }
        
        extension UIImageView {
            func setProductImageProperty() {
                self.layer.shadowColor = UIColor.grayColor().CGColor
                self.layer.shadowOffset = CGSizeMake(0, 1)
                self.layer.shadowOpacity = 1
                self.layer.shadowRadius = 5.0
                self.clipsToBounds = false
            }
        }
        
        extension String {
            
            var html2AttributedString: NSAttributedString? {
                guard
                    let data = dataUsingEncoding(NSUTF8StringEncoding)
                    else { return nil }
                do {
                    return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    return  nil
                }
            }
            var html2String: String {
                return html2AttributedString?.string ?? ""
            }
        }
        
        
        
        
        
        