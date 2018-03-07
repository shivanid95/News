//
//  NewsDataModel.swift
//  News
//
//  Created by Shivani Dosajh on 06/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift
// Response from the News Api
struct NewsArticlesResponse : Mappable {
    
    var status          : String?
    var totalItems      : Int?
    var articlesArray   : [NewsArticle]?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        status          <-  map ["status"]
        totalItems      <-  map ["totalResults"]
        articlesArray   <-  map ["articles"]
    }
    
}

//Single Article Entity
class NewsArticle :Object, Mappable {
    //MARK: - Properties
    @objc dynamic var title                    : String?
    @objc dynamic var articleDescription       : String?
    @objc dynamic var imageUrl                 : String?
    @objc dynamic var articleLinkUrl           : String?
    @objc dynamic var uniqueId = UUID().uuidString
    
    required convenience init?(map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "uniqueId"
    }
    
    //MARK : - Mapping
    func mapping(map: Map) {
        title                  <-  map["title"]
        articleDescription     <-  map["description"]
        articleLinkUrl         <-  map["url"]
        imageUrl               <-  map["urlToImage"]
    }
}

