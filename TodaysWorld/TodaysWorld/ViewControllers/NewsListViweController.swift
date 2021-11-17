//
//  NewsListViweController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/22/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NewsListViweController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let baseUrl:String = "https://newsapi.org/v2/"
    let apiKeyToken:String = "&apiKey=adc755b0a65d48c0ace6e723b8c9cb26"
    
    var articles: Array<Dictionary<String, Any>>?
    var searchOption:SearchOptionData?
    
    @IBOutlet weak var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTable.delegate = self
        newsTable.dataSource = self
        
        getArticlesByOption()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let article = self.articles{
            print("article count: \(article.count)")
            return article.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let index = indexPath.row
        if let news = self.articles{
            let article = news[index]
            if let row = article as? Dictionary<String, Any>{
                if let title = row["title"] as? String{
                    cell.newsTitle.text = title
                }
                if let imageUrl = row["urlToImage"] as? String{
                    if let imageData = try? Data(contentsOf: URL(string:imageUrl)!){
                        cell.newsImage.image = UIImage(data:imageData)
                    }
                }
            }
        }
        return cell
    }
    
    func getArticlesByOption(){
        var url = ""
        if searchOption == nil{
            url = baseUrl + "top-headlines?country=us" + apiKeyToken
            print("searchOption nil url:\(url)")
            
        }else{
            if let option = searchOption{
                if option.articleType == .TopHeadline{
                    url = baseUrl + "top-headlines?country=" + option.region.rawValue
                    url += "&category=" + option.category.rawValue
                    
                    
                }else{  // everything
                    url = baseUrl + "everything" + "?language=" + option.language!
                    url += "&from=" + option.fromDate!
                    url += "&to="+option.toDate!
                }
                
                url += "&q=" + option.toFindWord!
                url += apiKeyToken
                print("url's \(option.articleType): \(url)")
            }
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!){
            (data, response, error) in
            if let dataJson = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                        let newArticle = json["articles"] as! Array<Dictionary<String, Any>>
                        self.articles = newArticle
                        
                        DispatchQueue.main.async {
                            self.newsTable.reloadData()
                        }
                }catch{
                    let alertController = UIAlertController(title:"Notice", message: "please retry load the articles", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title:"Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let id = segue.identifier, id == "segueToArticleVC"{
            if let articleView = segue.destination as? ArticleViewController{
                if let idx = newsTable.indexPathForSelectedRow?.row{
                    if let news = articles{
                        if let article = news[idx] as? Dictionary<String, Any>{
                            let author:String
                            let description:String
                            let title:String
                            let url:String
                            let urlToImage:String
                            let publishedAt:String
                            let content:String
                            if let _author = article["author"] as? String{
                                author = _author
                            }else {
                                author = ""
                            }
                            
                            if let _description = article["description"] as? String{
                                description = _description
                            }else{
                                description = ""
                            }
                            
                            if let _title = article["title"] as? String{
                                title = _title
                            }else{
                                title = ""
                            }
                            
                            if let _url = article["url"] as? String{
                                url = _url
                            }else {
                                url = ""
                            }
                            
                            if let _urlToImage = article["urlToImage"] as? String{
                                urlToImage = _urlToImage
                            }else {
                                urlToImage = ""
                            }
                            
                            if let _publishedAt = article["publishedAt"] as? String{
                                publishedAt = _publishedAt
                            }else{
                                publishedAt = ""
                            }
                            
                            if let _content = article["content"] as? String{
                                content = _content
                            }else{
                                content = ""
                            }
                            articleView._articleData = articleData(_author: author, _title: title, _description: description, _url: url, _urlToImage: urlToImage, _publishedAt: publishedAt, _content: content)
                        }
                    }
                }
            }
        }
    }
    
}
