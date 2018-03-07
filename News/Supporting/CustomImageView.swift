//
//  ImageView(ext).swift
//  News
//
//  Created by Shivani Dosajh on 06/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView : UIImageView {
    
    var lastLoadedImageUrlString : String?
    
    func downloadImage(url: URL) {
        
        lastLoadedImageUrlString = url.absoluteString
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data,response , error) in
                if let imageData = data , let newImage = UIImage(data : imageData) {
                    DispatchQueue.main.async { [weak self] in
                        if self?.lastLoadedImageUrlString == url.absoluteString {
                            self?.image = newImage
                            }
                        imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                }
            }).resume()
        }
       
    }
    
}

