//
//  NewsViewController.swift
//  MandiriNews
//
//  Created by Alan Santoso on 12/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var asearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var article : [NewsModel]?
    var searchedArticle : [NewsModel]?
    
    var url = String()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchedArticle = article
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewViewController
        destinationVC.url = url
    }
    
    
}

extension NewsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedArticle?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        
        cell.nameLabel.text = searchedArticle?[indexPath.row].name
        cell.descriptionLabel.text = searchedArticle?[indexPath.row].sourceDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        url = searchedArticle?[indexPath.row].url ?? ""
        performSegue(withIdentifier: "webViewSegue", sender: self)
    }
    
    
}


extension NewsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searching = false
            searchedArticle = article
        }else{
            searching = true
            searchedArticle = article?.filter{($0.sourceDescription?.contains(searchText) ?? false)}
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
