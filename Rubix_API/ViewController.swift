//
//  ViewController.swift
//  Rubix_API
//
//  Created by Alex Bussan on 9/17/16.
//  Copyright © 2016 AlexBussan. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let urlImg = "https://c1.staticflickr.com/5/4034/4544827697_6f73866999_b.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findMainColorOfImageWithURL(URL: urlImg)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func useCamera(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
            newMedia = true
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        imageView.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func findMainColorOfImageWithURL(URL: String) {
        let headers: HTTPHeaders = [
            "X-Mashape-Key": "7y2as4tWCBmshfUT7x8ymCW1h37ip1fnQ7jjsnMpCwqgvOsstZ",
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://apicloud-colortag.p.mashape.com/tag-url.json?palette=simple&sort=relevance&url=\(URL)", headers: headers).responseJSON { response in
            
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
