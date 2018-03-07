//
//  UIViewController(ext).swift
//  News
//
//  Created by Shivani Dosajh on 07/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

extension UIViewController {
func showLoadingView() {
    
    let loadingView = UIView()
    loadingView.tag = 1098
    loadingView.frame = CGRect(x: UIScreen.main.bounds.width/2-40, y: UIScreen.main.bounds .height/2-80, width: 80, height: 80)
    loadingView.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    let actInd = UIActivityIndicatorView()
    actInd.tag = 1099
    actInd.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    actInd.transform = CGAffineTransform(scaleX: 2, y: 2)
    actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    actInd.startAnimating()
    
    loadingView.addSubview(actInd)
    self.view.addSubview(loadingView)
}

func hideLoadingView() {
    for subViews in self.view.subviews {
        if subViews.tag == 1098 {
            for subview in subViews.subviews {
                if subview.tag == 1099 {
                    subview.removeFromSuperview()
                }
            }
            subViews.removeFromSuperview()
        }
    }
}

}
