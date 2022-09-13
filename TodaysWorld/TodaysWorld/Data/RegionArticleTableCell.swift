//
//  RegionArticleCell.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/29/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit



class RegionArticleTableCell: UITableViewCell{
    
    @IBOutlet weak var regionEmoji: UILabel!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    var cellDelegate:CustomCellButtonDelegate!
    var articleCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.articleCollectionView.delegate = self
//        self.articleCollectionView.dataSource = self
        self.articleCollectionView.register(UINib(nibName: "RegionArticleCollectionCell", bundle: nil), forCellWithReuseIdentifier: "RegionArticleCollectionCell")
        self.articleCollectionView.delegate = self
        self.articleCollectionView.dataSource = self
    }
    
    func setCell(region:E_Region){
        regionEmoji.text = region.getStringType
        NewsArticleReceiver.sharedInstance.getArticles(type: .TopHeadline, countryType: region, categoryType: .None, isPreview: true){
            DispatchQueue.main.async {
                if let articles = NewsArticleReceiver.sharedInstance.articles {
                    self.articleCount = articles.count
                }else{
                    self.articleCount = 0
                }
                 
                self.articleCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func OnClickedBtnViewAll(_ sender: Any) {
        if self.cellDelegate != nil{
            self.cellDelegate.onClickedBtn()
        }
    }
}

extension RegionArticleTableCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionArticleCollectionCell", for: indexPath) as! RegionArticleCollectionCell
        
        if let articleData = NewsArticleReceiver.sharedInstance.cachedArticleImageDic[indexPath.row]{
            cell.setCell(newsImage: articleData.image, newsTitle: articleData.title!, newsSource: articleData.source!, newsPublishedAt: articleData.publishedAt!)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("[RegionArticleTableCell] count: \(articleCount)")
        return articleCount
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("[RegionArticleTableCell] didselectedItemAt : \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt:IndexPath) -> CGSize{
        return CGSize(width: 400, height: 400)
    }
    
    
}
