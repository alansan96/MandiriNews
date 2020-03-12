//
//  ViewController.swift
//  MandiriNews
//
//  Created by Alan Santoso on 12/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VAR
    var allNews = [NewsModel]()
    var category = [String]()
    var specificArticle = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "News"
        fetchArticle()
    }
    
    func fetchArticle(){
        let url  = "https://newsapi.org/v1/sources?category="
        APIClient.shared.fetchAllArticles(with: URL(string: url)!) { (result) in
            switch result{
            case .success(let news):
                self.allNews = news
                self.filterCategory(news: news)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filterCategory(news : [NewsModel]){
        var dict = [String:Int]()
        news.forEach { (oneNew) in
            dict[oneNew.category!] = 1
        }
        
        dict.forEach { (key,value) in
            category.append(key)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - SEGUE HANDLER
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! NewsViewController
        destinationVC.article = specificArticle
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.textLabel?.text = category[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let allarticleofCategory = allNews.filter{$0.category == category[indexPath.row]}
        specificArticle = allarticleofCategory
        print(specificArticle)
        
        self.performSegue(withIdentifier: "articleSegue", sender: self)
        
        
    }
    
    
}

