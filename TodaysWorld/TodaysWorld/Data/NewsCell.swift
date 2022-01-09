//
//  NewsCell.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/22/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    var imageUrl:String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init? (coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
