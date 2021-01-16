//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Marcio Habigzang Brufatto on 14/01/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell does not exist")
        }
        
        cell.titleLable.text = self.articles[indexPath.row].title
        cell.descriptionLable.text = self.articles[indexPath.row].description
        
        return cell
    }
    
    private func populateNews() {
        
        //let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0cf790498275413a9247f8b94b3843fd")!
        
        //let resource = Resource<ArticlesList>(url: url)
        
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                self?.articles = result.articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
        
    }
}

