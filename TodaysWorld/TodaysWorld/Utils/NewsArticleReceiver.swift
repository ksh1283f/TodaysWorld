//
//  NewsArticleReceiver.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/28/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NewsArticleReceiver {
    static let sharedInstance = NewsArticleReceiver()
    
    fileprivate let baseUrl = "https://newsapi.org/v2/top-headlines?"
    fileprivate var apiKey:String = ""
    fileprivate var apiKeyToken = "&apiKey="
    var articles:Array<Dictionary<String, Any>>?
    var cachedArticleImageDic:Dictionary<Int, ArticleImageData> = [:]
    var searchOption:SearchOptionData?
    
    init(){
        apiKey = getApiKey()
        
    }
    
    func getApiKey()-> String{
        if apiKey != ""{
            return apiKey
        }
        
        var result = ""
        if let apiKeyPlistPath = Bundle.main.path(forResource: "apiKey", ofType: "plist"){
            let data = NSMutableDictionary(contentsOfFile: apiKeyPlistPath)
            let key = data?.value(forKey: "apiKey") as? String
            if let _key = key{
                result = _key
            }
        }
        
        return result
    }
    
    func getArticlesNew(type:E_ArticleType, countryType:E_Region, categoryType:E_Category,isPreview:Bool,  onCompleted: @escaping ()->Void){
        
    }
    
    func getArticles(type:E_ArticleType, countryType:E_Region, categoryType:E_Category,isPreview:Bool,  onCompleted: @escaping ()->Void){
        var url = baseUrl
        if type == .TopHeadline{
            url += "country="
            if countryType.rawValue == ""{
                url += "us"// chance
            }else{
                url += countryType.rawValue
            }
            
        }else{
            url += "category="
            if categoryType.rawValue == ""{
                url += E_Category.General.rawValue
            }else{
                url += categoryType.rawValue
            }
        }
        
        url += isPreview ? "&pageSize=7" : ""
        
        // api key
        url += apiKeyToken + apiKey
        //print("[NesArticleReceiver] req url: \(url)")
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!){ (data, response, err) in
            if let dataJson = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    if let newArticle = json["articles"] as? Array<Dictionary<String, Any>>{
                        self.articles = newArticle
                        
                        for (index, article) in newArticle.enumerated(){
                            if let row = article as? Dictionary<String, Any>{
                                let defaultValue = "Unknown"
                                let title = row["title"] as? String ?? defaultValue
                                
                                let publishedAt = row["publishedAt"] as? String ?? defaultValue
                                let desc = row["description"] as? String ?? defaultValue
                                var sourceName = defaultValue

                                if let rowSource = row["source"] as? Dictionary<String, String>,
                                   let name = rowSource["name"] as? String{
                                    sourceName = name
                                }
                                
                                if let rowImage = row["urlImage"] as? String{
                                    if let imageData = try? Data(contentsOf: URL(string: rowImage)!){
                                        let cachedItem = ArticleImageData(image: UIImage(data: imageData)!, title: title, source: sourceName, desc: desc, publishedAt: publishedAt)
                                        self.cachedArticleImageDic[index] = cachedItem
                                    }
                                }
                            }
                        }
                        
                        onCompleted()   // self.newsTable.reloadData()
                    }
                }catch{
                    if let vc = UIApplication.shared.keyWindow?.visibleViewController as? UIViewController{
                        let alertController = UIAlertController(title:"Notice", message: "\(err?.localizedDescription)", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        vc.present(alertController, animated: true)
                    }
                }
            }
        }
        
        task.resume()
    }
}
