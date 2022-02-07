# TodaysWorld

[![Xcode](https://img.shields.io/badge/Xcode-11.0-blue)](https://developer.apple.com/xcode/) ![Platform](https://img.shields.io/badge/iOS-13.2-green)  


>TodaysWorld is a simple news app. you can see the top headline of your country or other countries with options
<p align="center">
    <img src="Imgs/Example.gif" width = "200">
</p>

## Prerequisite
1. NEWS API
    - Go to News API [NewsApi link](https://newsapi.org/)
    - If you don't have your account, please sign up and get api key.
    - before step is done, open your xcode, make directory <b>ApiKey</b> and make <b>apiKey.plist</b>  
    ![DirectoryExample.png](Imgs/DirectoryExample.png) 
    - set the key <b>apiKey</b> and insert api key you made into the value  
    ![apiKey.PlistExample](Imgs/apiKeyPlistExample.png)  

2. Firebase Authentication
   - Implement Firebase Authentication [Firebase Auth docs](https://firebase.google.com/docs/auth/ios/google-signin?authuser=0)

## Storyboard
![Storyboard](Imgs/storyboard.png)

## Notice
> Your top headlines article would be selected according to your device's first language. Therefore if the article's language is not your country's, please check <b>Settings -> Language</b>



