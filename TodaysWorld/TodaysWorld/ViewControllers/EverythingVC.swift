//
//  EverythingVC.swift
//  TodaysWorld
//
//  Created by Seunghyeon Kang on 7/24/22.
//  Copyright © 2022 Seunghyeon Kang. All rights reserved.
//

import UIKit
import Lottie

class EverythingVC: UIViewController {

    let animationView = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = self.title
        setupAni(name: "robot_note")
    }
    
}

// test lottie
extension EverythingVC{
    func setupAni(name:String){
        animationView.frame = view.bounds
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
}
