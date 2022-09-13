//
//  TopHeadlineVC.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/24/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import UIKit

protocol CustomCellButtonDelegate {
    func onClickedBtn()
}

class TopHeadlineVC: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    
    let baseUrl = "https://newsapi.org/v2/"
    var apiKeyToken = "&apiKey="
    
    var articles: Array<Dictionary<String, Any>>?
    var cachedArticleImageDic:Dictionary<Int, ArticleImageData> = [:]
    var searchOption:SearchOptionData?
    var countries:[E_Region] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = E_Region.allCases.filter{$0 != .None}
        
        self.newsTable.delegate = self
        self.newsTable.dataSource = self

        self.newsTable.register(UINib(nibName: "RegionArticleTableCell", bundle: nil), forCellReuseIdentifier: "RegionArticleTableCell")
        self.newsTable.separatorStyle = .none
        
        self.newsTable.rowHeight = UITableView.automaticDimension
        self.newsTable.estimatedRowHeight = 350
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = self.title
    }
    
    func getApiKey() -> String{
        var result = ""
        
        if let apiKeyPlistPath = Bundle.main.path(forResource: "apiKey", ofType: "plist"){
            let data = NSMutableDictionary(contentsOfFile: apiKeyPlistPath)
            let key = data?.value(forKey: "apiKey") as? String
            if let _key = key{
                result = _key
            }
        }else{
            print("[TopHeadlineVC] apiKeyPlistPath is nil")
        }
        
        return result
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension TopHeadlineVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionArticleTableCell", for: indexPath) as! RegionArticleTableCell
        print("[TopHeadlineVC] cellForRowAt: \(indexPath.row)")
        cell.cellDelegate = self
        cell.setCell(region: countries[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return countries.count
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension TopHeadlineVC : CustomCellButtonDelegate{
    func onClickedBtn() {
        self.performSegue(withIdentifier: "ShowArticleListView", sender: self)
    }
}
