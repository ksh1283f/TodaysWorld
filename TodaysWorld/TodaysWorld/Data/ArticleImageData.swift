//
//  ArticleImageData.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 1/6/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import UIKit

struct ArticleImageData{
    var image:UIImage
    var title: String?
    var source: String?
    var desc: String?
    var publishedAt:String?
    
    init(image:UIImage, title:String, source:String, desc:String, publishedAt:String){
        self.image = image
        self.title = title
        self.source = source
        self.desc = desc
        self.publishedAt = publishedAt
    }
}
