//
//  ArticleOptionViewController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/21/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit

class ArticleOptionViewController: UIViewController {
    
    var regionList:Array<E_Region> = []
    var categoryList:Array<E_Category>=[]
    var selectedRegion:E_Region = .None
    var selectedCategory:E_Category = .None
    var selectedLanguage:E_Language = .None
    var selectedArticleType:E_ArticleType = .TopHeadline
    var dateFormat = DateFormatter()
    
    override func viewDidLoad() {
        // init data
//        initRegionData()
//        initCategoryData()
//
//        selectedCategory = .Business
//        selectedRegion = .Argentina
//
//        dateFormat.dateFormat = "yyyy-MM-dd"
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return regionList.count
        }else{
            return categoryList.count
        }
    }
    
    // Number of columns of data
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
   }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            selectedRegion = regionList[row]
            return "\(regionList[row])"
        }else{
            selectedCategory = categoryList[row]
            return "\(categoryList[row])"
        }
    }
    
    func initRegionData(){
        for region in E_Region.allCases{
            if region == .None{
                continue
            }
                
            regionList.append(region)
        }
    }
    
    func initCategoryData(){
        for category in E_Category.allCases{
            if category == .None{
                continue
            }
            
            categoryList.append(category)
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("test prepare1")
        if let id = segue.identifier, id == "segueToNewsListVC"{
            if let newsListVC = segue.destination as? NewsListViweController{
                
            }
        }
    }
}
