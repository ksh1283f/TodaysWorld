//
//  LoginViewController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 4/16/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//


import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnGoogleLogin: GIDSignInButton!
    
    var dbRef:DatabaseReference!
    var googleUserInfo:GIDProfileData!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // db 인스턴스 초기화
        dbRef = Database.database().reference()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
          // TODO(developer) Configure the sign-in button look/feel
          // ...
        
        if GIDSignIn.sharedInstance()?.currentUser == nil{
            setBtnsWithLoginResult(false)
        }
    }
    
    func onLogin(isSuccess:Bool){
        // debug
        if isSuccess{
            print("login success!")
            
            if let userID = Auth.auth().currentUser?.uid{
                dbRef.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                  // Get user value
                  let value = snapshot.value as? NSDictionary
    //              let username = value?["username"] as? String ?? ""
                    // register new user
                    if value == nil{
                        self.googleUserInfo = GIDSignIn.sharedInstance()?.currentUser.profile
                        if self.googleUserInfo != nil{
                            self.dbRef.child("users").child(userID ?? "").setValue(["name": self.googleUserInfo.givenName+" "+self.googleUserInfo.familyName, "email":self.googleUserInfo.email])
                        }
                    }
                  }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }else{
            print("login failed!")
        }
        
        setBtnsWithLoginResult(isSuccess)
        //db 작업
       
    }
    
    func setBtnsWithLoginResult(_ isSuccess:Bool){
        btnGoogleLogin.isUserInteractionEnabled = !isSuccess
        btnGoogleLogin.isHidden = isSuccess
        btnNext.isUserInteractionEnabled = isSuccess
        btnNext.isHidden = !isSuccess
        btnSignOut.isUserInteractionEnabled = isSuccess
        btnSignOut.isHidden = !isSuccess
    }
   
    @IBAction func OnClickedBtnSignOut(_ sender: Any) {
        if GIDSignIn.sharedInstance()?.currentUser == nil{
            return
        }
        GIDSignIn.sharedInstance()?.signOut()
        setBtnsWithLoginResult(false)
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}
