//
//  OriginalSourceViewController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/22/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class OriginalSourceViewController:UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _urlString = urlString{
            if let url = URL(string: _urlString){
                let urlReq = URLRequest(url: url)
                webView.load(urlReq)
            }
        }
    }
}
