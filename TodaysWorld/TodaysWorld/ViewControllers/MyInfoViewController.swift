//
//  MyInfoViewController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/19/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import Firebase

class MyInfoViewController: UIViewController{//,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var imageMyPicture: UIImageView!
    @IBOutlet weak var labelMyInfo: UILabel!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    
    var languages:[E_Language]?
    var selectedLanguage:E_Language = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        }catch let signOutError as NSError {
            print("error signing out : %@", signOutError)
        }
        
        imageMyPicture.layer.masksToBounds = true
        imageMyPicture.layer.cornerRadius = imageMyPicture.bounds.width / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateLoginStatus()
        btnGoogleLogin.titleLabel?.text = ""
        self.tabBarController?.navigationItem.title = self.title
    }
    
    @IBAction func onClickedBtnGoogleLogin(_ sender: Any) {
        LoadingView.startLoading()
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration.init(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [unowned self] user, error in
            if let err = error{
                let alert = UIAlertController(title: "Login failed", message: err.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Ok", style: .default){ _ in
                    LoadingView.endLoading()
                    return })
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential){ authResult, error in
                if let err = error{
                    print("login failed: \(err.localizedDescription)")
                    LoadingView.endLoading()
                }else{
                    print("login success")
                    updateLoginStatus()
                    
                }
            }
        }
    }
    
    
    func updateLoginStatus(){
        if let user = Auth.auth().currentUser{
            btnGoogleLogin.isHidden = true
            guard let userName = user.displayName else { return }
            DispatchQueue.main.async {
                self.labelMyInfo.text = userName
            }

            if let profile = user.photoURL{
                if let data = try? Data(contentsOf: profile) {
                    DispatchQueue.main.async {
                        self.btnGoogleLogin.isHidden = true
                        self.imageMyPicture.image = UIImage(data: data)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            LoadingView.endLoading()
                        }
                    }
                }
            }
            
            
        }else{
            btnGoogleLogin.isHidden = false
            DispatchQueue.main.async {
                self.labelMyInfo.text = "Anonymous user"
            }
            LoadingView.endLoading()
        }
    }
    
    
    
    //------------------------------------------------------------
    func initMyLanguage(){
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = (Locale(identifier: localeID!).languageCode)!
        print("my device language:\(deviceLocale)")
        print("my prefferredLan:\(Locale.preferredLanguages)")
        languages = Array<E_Language>()
        //1. 기기의 언어값을 받는다
        //2. 받은 언어의 값으로 언어코드를 세팅
        
        for language in E_Language.allCases{
            if language == .None{
                continue
            }
            
            languages?.append(language)
            if localeID! == language.rawValue{
                selectedLanguage = language
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let id = segue.identifier, id == "segueToArticleOptionVC"{
            if let articleOptionVC = segue.destination as? ArticleOptionViewController{
                articleOptionVC.selectedLanguage = self.selectedLanguage
            }
        }
    }
}
