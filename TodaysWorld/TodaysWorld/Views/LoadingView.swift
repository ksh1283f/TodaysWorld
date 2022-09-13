//
//  LoadingView.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/24/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit

class LoadingView {
    static var mainWindow:UIWindow?
    static func startLoading(){
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            mainWindow = window
            
            let loadingIndicatorView: UIActivityIndicatorView
            if let existedView = window.subviews.first(where: {$0 is UIActivityIndicatorView}) as? UIActivityIndicatorView{
                loadingIndicatorView = existedView
            }else {
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = .brown
                window.addSubview(loadingIndicatorView)
            }
            
            loadingIndicatorView.startAnimating()
        }
        
    }
   
    static func endLoading(){
        DispatchQueue.main.async {
            if let window = mainWindow{
                window.subviews.filter({$0 is UIActivityIndicatorView}).forEach{$0.removeFromSuperview()}
                mainWindow = nil
            }
        }
    }
}

