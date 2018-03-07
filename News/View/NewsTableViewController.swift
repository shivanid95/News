//
//  NewsTableViewController.swift
//  News
//
//  Created by Shivani Dosajh on 05/03/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var viewModel : NewsViewModel? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
// MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // registering Reusable table view cells
        let newsNib = UINib(nibName: Constants.tableViewCellNibName, bundle: nil)
        tableView.register(newsNib, forCellReuseIdentifier: Constants.tableViewCellReuseId)
        showLoadingView()
        
        // set up dynamic cell height for table views
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180
        
        // Initialize View Model
        viewModel = NewsViewModelImplementation()
        viewModel?.model = NewsModelImplementation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count =  viewModel?.numberOfItems() else {return}
        
        if indexPath.row  == count - 1 {
            viewModel?.fetchChunkOfData()
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellReuseId ,for: indexPath) as? NewsArticleTableViewCell ,
            let article = viewModel?.useItemAt(index: indexPath) else {
                return UITableViewCell()
         }
// loading cell with data
        cell.loadCell(article : article)
        return cell
    }

}
//MARK: - News View Delegate
extension NewsTableViewController : NewsViewDelegate {
    
// Called after data fetched from API
    func updateTableView() {
        tableView.reloadData()
        hideLoadingView()
        
        
    }

}
