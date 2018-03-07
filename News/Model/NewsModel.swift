//
//  NewsModel.swift
//  News
//
//  Created by Shivani Dosajh on 06/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

protocol NewsModelDelegate {
    func didLoadNewsArticles()
    
}
protocol NewsModel {
    // returns the list of articles
    func fetchArticles (completionHandler : @escaping([NewsArticle]? , Error? ) -> Void)
    var delegate : NewsModelDelegate? { get set }
    func fetchData(fromIndex index: Int , completinHandler : @escaping([NewsArticle]?) -> Void )
}

//Implementation of News Model

class NewsModelImplementation : NewsModel {
    
    init() {
        fetchArticles { [weak self] (articles, error) in
            self?.newsArticlesArray = articles
        }
        
    }
    
    var delegate: NewsModelDelegate?
    var shouldLoadMoreData : Bool = true
    let realm = try! Realm()
    private var newsArticlesArray : [NewsArticle]? {
        didSet {
            delegate?.didLoadNewsArticles()
        }
    }
    
    func fetchData(fromIndex index: Int , completinHandler : @escaping([NewsArticle]?) -> Void ) {
        
        guard newsArticlesArray != nil else { return }
        
        var rangeStartIndex = index
        
        // handle start index out of bounds
        if rangeStartIndex < 0 {
            rangeStartIndex = 0
        } else if rangeStartIndex > newsArticlesArray!.endIndex {
            shouldLoadMoreData = false
            rangeStartIndex = newsArticlesArray!.endIndex
        }
        
        // handle end index out of bounds
        var rangeEndIndex = index + Constants.fetchLimit
        if rangeEndIndex > newsArticlesArray!.endIndex {
            rangeEndIndex = newsArticlesArray!.endIndex
        }
        if shouldLoadMoreData {
            DispatchQueue.global().async { [weak self] in
                completinHandler( Array(self!.newsArticlesArray![rangeStartIndex..<rangeEndIndex]))
            }
            
        }
        
    }
    
    
    
    func fetchArticles (completionHandler : @escaping([NewsArticle]? , Error? ) -> Void) {
        DispatchQueue.global().async {
            Alamofire.request(URL(string :Constants.getNewsArticlesUrlString )!, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted , headers: nil).validate().responseObject {[weak self]  (response : DataResponse<NewsArticlesResponse>) in
                
                switch response.result {
                case .success(let value) :
                    completionHandler(value.articlesArray , nil)
                    self?.saveDataToRealm(articles: value.articlesArray)
                case .failure(let error ) :
                    completionHandler(nil, error)
                }
            }
        }
        
    }
    
    // Saving Data To Realm
    func saveDataToRealm(articles : [NewsArticle]?) {
        try! self.realm.write {
            self.realm.add(articles!, update : false)        }
        
    }
    func removeRealmData() {
        try! realm.write {
            realm.deleteAll()
        }
    }

}

