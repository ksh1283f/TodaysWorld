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
    
    init(image:UIImage, title:String){
        self.image = image
        self.title = title
    }
}
