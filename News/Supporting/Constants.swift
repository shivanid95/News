//
//  Constants.swift
//  News
//
//  Created by Shivani Dosajh on 05/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation

enum Constants {
    static let tableViewCellNibName     = "NewsArticleTableViewCell"
    static let tableViewCellReuseId     = "NewsArticleTVCellID"
    // Url string to get news articles
    static let getNewsArticlesUrlString = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=a8fabd9ff4234c82aad08eaaa4ea17a0"
    //load new articles after threshhold
    static var fetchThreshHold = 1
    // loading articles in chumcks of fetchLimit variable
    static var fetchLimit = 5

}
