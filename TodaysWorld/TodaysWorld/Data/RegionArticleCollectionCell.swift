//
//  RegionArticleCollectionCell.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/29/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit

class RegionArticleCollectionCell : UICollectionViewCell{
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsPublishedAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImage.layer.cornerRadius = 8
        newsImage.backgroundColor = .green
        self.backgroundColor = .red
        self.newsTitle.backgroundColor = .yellow
        self.newsSource.backgroundColor = .gray
        self.newsPublishedAt.backgroundColor = .brown
    }
    
    func setCell(newsImage:UIImage, newsTitle:String, newsSource:String, newsPublishedAt: String){
        
        print("RegionArticleCollectionCell:Setcell")
        self.newsImage.image = newsImage
        self.newsTitle.text = newsTitle
        self.newsSource.text = newsSource
        self.newsPublishedAt.text = newsPublishedAt
    }
}
