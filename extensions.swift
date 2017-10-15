//
//  extensions.swift
//  tigerHacks
//
//  Created by Brett Young on 10/14/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import Firebase



let imageCache = NSCache<AnyObject, UIImage>()
var currentUserImg = UIImage()


extension UIImageView {
    
    func cacheImage(url: String, uid: String){
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage{
            self.image = cachedImage
        }
            let imgUrl = URL(string: url)
            URLSession.shared.dataTask(with: imgUrl!)
            URLSession.shared.dataTask(with: imgUrl!, completionHandler: {(data, response, error) in
                if error != nil{
                    print("imageError", error)
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let image = UIImage(data: data) {
                            imageCache.setObject(image, forKey: url as AnyObject)
                            self.image = image
                         
                        }
                    }
                }
            }).resume()
    
    }
}
