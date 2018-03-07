//
//  NewsViewModel.swift
//  News
//
//  Created by Shivani Dosajh on 06/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
// delegates all UI related activities to view
protocol NewsViewDelegate {
    func updateTableView()
}

protocol NewsViewModel {
// returns the total number of articles
    func numberOfItems() -> Int
// returns article object for indexPath
    func useItemAt( index : IndexPath) -> NewsArticle?

    var model : NewsModel? { get set}
    var viewDelegate : NewsViewDelegate? { get set}
    var loadFromIndex : Int {get set}
    func fetchChunkOfData()
}

class NewsViewModelImplementation : NewsViewModel {
    
    private var articlesArray = [NewsArticle]()
    var loadFromIndex = 0
    var viewDelegate: NewsViewDelegate?
    var model: NewsModel? {
        didSet {
            model?.delegate = self
        }
    }

    func numberOfItems() -> Int {
        return articlesArray.count     }
    
    func useItemAt(index: IndexPath) -> NewsArticle? {
        return articlesArray[index.row]
        
    }
    
    func fetchChunkOfData() {
        model?.fetchData(fromIndex: loadFromIndex, completinHandler: { [weak self] (articles) in
            for item in articles! {
                self?.articlesArray.append(item)
            }
            self?.loadFromIndex += Constants.fetchLimit
            DispatchQueue.main.async {
                   self?.viewDelegate?.updateTableView()
            }
         
        })
    }
    
}

extension NewsViewModelImplementation : NewsModelDelegate {
    func didLoadNewsArticles() {
        fetchChunkOfData()
        
    }
}
