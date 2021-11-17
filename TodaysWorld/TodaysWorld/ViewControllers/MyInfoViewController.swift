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

class MyInfoViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var imageMyPicture: UIImageView!
    @IBOutlet weak var labelMyInfo: UILabel!
    @IBOutlet weak var btnFindBus: UIButton!
    @IBOutlet weak var LanguagePicker: UIPickerView!
    var languages:[E_Language]?
    var selectedLanguage:E_Language = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LanguagePicker.dataSource = self
        self.LanguagePicker.delegate = self
        
        if let instance = GIDSignIn.sharedInstance(){
            if let user = instance.currentUser{
                // myInfo
                labelMyInfo.text = user.profile.givenName+" "+user.profile.familyName+"\n"+user.profile.email
                // profile image
                if user.profile.hasImage{
                    let dimension = round(374 * UIScreen.main.scale)
                    let pic = user.profile.imageURL(withDimension: UInt(dimension))
                    if let data = try? Data(contentsOf: pic!){
                        // data객체를 이용하여 UIImage 초기화(Main thread)
                        DispatchQueue.main.async {
                            self.imageMyPicture.image = UIImage(data: data)
                        }
                    }
                }
                
            }else{
                labelMyInfo.text = "there is no login info"
            }
        }
        
        initMyLanguage()
    }
    
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
    
    // The number of rows of data
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages!.count
     }
     
     // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
     // The data to return fopr the row and component (column) that's being passed in
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
             return "\(languages![row])"
     }
    
    private func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedLanguage = languages![row]
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
