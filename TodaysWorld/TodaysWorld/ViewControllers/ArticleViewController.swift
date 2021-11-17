//
//  ArticleViewController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/22/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController {
    

    @IBOutlet weak var articleDesc: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    var _articleData:articleData? = nil
    var labelData:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = _articleData{
            if let title = article.title{
                labelData += title
                labelData += "\n\n"
            }
            
            if let author = article.author{
                labelData += author
                labelData += "\n\n"
            }
            
            if let publishedAt = article.publishedAt{
                labelData += publishedAt
                labelData += "\n\n"
                
            }
            if let description = article.description{
                labelData += description
                labelData += "\n\n"
            }
            if let content = article.content{
                labelData += content
            }
            articleDesc.text = labelData
            
            if let urlImage = article.urlToImage{
                if let imageData = try? Data(contentsOf: URL(string: urlImage)!){
                    DispatchQueue.main.async {
                        self.newsImageView.image = UIImage(data:imageData)
                        
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let id = segue.identifier, id == "segueToOriginalVC"{
            if let originalSourceVC = segue.destination as? OriginalSourceViewController{
                if let data = _articleData{
                    if let urlString = data.url{
                        originalSourceVC.urlString = urlString
                    }
                }
            }
        }
    }
}
