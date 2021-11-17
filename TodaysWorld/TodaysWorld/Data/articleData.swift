//
//  articleData.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/21/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//


import Foundation

class articleData{
    public let author:String?
    public let title:String?
    public let description:String?
    public let url:String?
    public let urlToImage:String?
    public let publishedAt:String?
    public let content:String?
    
    init(_author:String, _title:String, _description:String, _url:String, _urlToImage:String, _publishedAt:String, _content:String) {
        author = _author
        title = _title
        description = _description
        url = _url
        urlToImage = _urlToImage
        publishedAt = _publishedAt
        content = _content
    }
}
