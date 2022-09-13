//
//  GoogleUserData.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 4/18/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import GoogleSignIn

//
//class UserData:Singleton{
//    
//}

//class GoogleUserData: UserData {
class GoogleUserData{
    public let userId:String
    public let idToken:String
    public let fullName:String
    public let givenName:String
    public let familyName:String
    public let email:String
    public let hasImage:Bool
    public let profileImage:NSURL?
    
    public init(gUser:GIDGoogleUser) {
        userId = ""//gUser.userID
        idToken = ""//gUser.authentication.idToken
        fullName = ""//gUser.profile.name
        givenName = ""//gUser.profile.givenName
        familyName = ""//gUser.profile?.familyName
        email = ""//gUser.profile.email
        hasImage = false//gUser.profile.hasImage
        if hasImage {
            profileImage = nil//gUser.profile.imageURL(withDimension: 100) as! NSURL
        }else{
            profileImage = nil
        }
    }
    
}
