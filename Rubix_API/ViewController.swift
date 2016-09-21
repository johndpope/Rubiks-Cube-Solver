//
//  ViewController.swift
//  Rubix_API
//
//  Created by Alex Bussan on 9/17/16.
//  Copyright © 2016 AlexBussan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let urlImg = "https://c1.staticflickr.com/5/4034/4544827697_6f73866999_b.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findMainColorOfImageWithURL(URL: urlImg)
    }
    
    func findMainColorOfImageWithURL(URL: String) {
        let headers: HTTPHeaders = [
            "X-Mashape-Key": "7y2as4tWCBmshfUT7x8ymCW1h37ip1fnQ7jjsnMpCwqgvOsstZ",
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://apicloud-colortag.p.mashape.com/tag-url.json?palette=simple&sort=relevance&url=https://c1.staticflickr.com/5/4034/4544827697_6f73866999_b.jpg", headers: headers).responseJSON { response in
            
            print(response.debugDescription)
            
            if let result = response.result.value {
                if let resultDict = result as? NSDictionary {
                    if let colorsArr = resultDict["tags"] as? [[String : AnyObject]] {
                        
                        let firstColorDict = colorsArr[0]
                        if let firstColor = firstColorDict["label"] as? String {
                            print("Main Color Identified: \(firstColor)")
                        }
                    }
                }
            }
        }
    }
}
