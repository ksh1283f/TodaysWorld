//
//  TopHeadlineCell.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/24/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit

class TopHeadlineCell : UITableViewCell{
    
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init? (coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib \(self.titleLabel.text!) \(self.sourceLabel.text!)")
    
        
    }
    
    func setCell(newsImage:UIImage ,titleData: String, sourceData: String){
        print("setcell : \(titleData) \(sourceData)")
        self.newsImageView.image = newsImage
        self.titleLabel.text = titleData
        self.sourceLabel.text = sourceData
        
    }
    
}
