//
//  NewsArticleTableViewCell.swift
//  News
//
//  Created by Shivani Dosajh on 05/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

class NewsArticleTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var articleDescripitonLabel  : UILabel!
    @IBOutlet fileprivate weak var articleHeadingLabel      : UILabel!
    @IBOutlet fileprivate weak var articleImageView         : CustomImageView!
    @IBOutlet fileprivate weak var articleLinkUrlTextView   : UITextView! {
        didSet {
            articleLinkUrlTextView.delegate = self
        }
    }

    private var lastImageUrl : String?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
// loads the table view cell with data
    func loadCell( article : NewsArticle) {
        articleImageView.image = nil
        articleHeadingLabel.text = article.title
        articleDescripitonLabel.text = article.articleDescription
        articleLinkUrlTextView.text = article.articleLinkUrl
        
        if let imageUrl = article.imageUrl {
            articleImageView.downloadImage(url: URL(string :imageUrl)!)
        } else {
            articleImageView.image = #imageLiteral(resourceName: "placeholder")
            }
    }
    

}
//MARK: - Text View Delegate
extension NewsArticleTableViewCell : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}
