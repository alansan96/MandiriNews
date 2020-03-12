//
//  NewsViewController.swift
//  MandiriNews
//
//  Created by Alan Santoso on 12/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var article : [NewsModel]?
    
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        article?.forEach({ (article) in
        //            print(article.name, article.sourceDescription)
        //        })
        //
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewViewController
        destinationVC.url = url
    }
    
    
}

extension NewsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.nameLabel.text = article?[indexPath.row].name
        cell.descriptionLabel.text = article?[indexPath.row].sourceDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        url = article?[indexPath.row].url ?? ""
        performSegue(withIdentifier: "webViewSegue", sender: self)
    }
    
    
}
