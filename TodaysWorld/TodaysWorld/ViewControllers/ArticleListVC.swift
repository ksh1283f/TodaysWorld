//
//  ArticleListVc.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/29/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import UIKit


class ArticleListVC: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    
    var articles: Array<Dictionary<String, Any>>?
    var cachedArticleImageDic:Dictionary<Int, ArticleImageData> = [:]
    var searchOption:SearchOptionData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newsTable.dataSource = self
        self.newsTable.delegate = self
        
        self.newsTable.rowHeight = UITableView.automaticDimension
        self.newsTable.estimatedRowHeight = 350
    }
    
    
}

extension ArticleListVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"topHeadlineCell" , for: indexPath) as! TopHeadlineCell

        cell.titleLabel.text = self.cachedArticleImageDic[indexPath.row]?.title

        cell.setNeedsLayout()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let article = self.articles{
            print("article count: \(article.count)")
            return article.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
