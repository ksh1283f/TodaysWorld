//
//  ArticleOptionViewController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/21/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit

class ArticleOptionViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var regionPicker: UIPickerView!
    @IBOutlet weak var datePickerSwitch: UISwitch!
    @IBOutlet weak var findFromDatePicker: UIDatePicker!
    @IBOutlet weak var findToDatePicker: UIDatePicker!
    @IBOutlet weak var articleTypeOption: UISegmentedControl!
    @IBOutlet weak var toFindWordText: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var regionList:Array<E_Region> = []
    var categoryList:Array<E_Category>=[]
    var selectedRegion:E_Region = .None
    var selectedCategory:E_Category = .None
    var selectedLanguage:E_Language = .None
    var selectedArticleType:E_ArticleType = .TopHeadline
    var dateFormat = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.regionPicker.delegate = self
        self.regionPicker.dataSource = self
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        lockDatePickerSwitch(isLock: false)
        
        // init data
        initRegionData()
        initCategoryData()
        initDatePicker()
        
        selectedCategory = .Business
        selectedRegion = .Argentina
        
        dateFormat.dateFormat = "yyyy-MM-dd"
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
    
    func initDatePicker(){
        // 12월 ~ 1월 체크
        let current = Date()
        let aMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: current)
         //from: minium is a month ago, maximum is current date
        findFromDatePicker.maximumDate = current
        findFromDatePicker.minimumDate = aMonthAgo
        // to: maximum is a current date, mimum is 'from date'
        findToDatePicker.maximumDate = current
        findToDatePicker.minimumDate = findFromDatePicker.date
    }
    
    private func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 0{
            selectedRegion = regionList[row]
        }else{
            selectedCategory = categoryList[row]
        }
     }
    
    @IBAction func OnChangedArticleType(_ sender: Any) {
        if articleTypeOption.selectedSegmentIndex == 0 {
            // top headline
            selectedArticleType = .TopHeadline
            categoryPicker.isUserInteractionEnabled = true
            categoryPicker.alpha = 1.0
            
            if datePickerSwitch.isOn {
               datePickerSwitch.isOn = false
            }
            lockDatePickerSwitch(isLock: datePickerSwitch.isOn)
            datePickerSwitch.isUserInteractionEnabled = false
            regionPicker.isUserInteractionEnabled = true
            regionPicker.alpha = 1.0
            
        }else{
            // everything
            selectedArticleType = .Everything
            categoryPicker.isUserInteractionEnabled = false
            categoryPicker.alpha = 0.5
            datePickerSwitch.isUserInteractionEnabled = true
            regionPicker.isUserInteractionEnabled = false
            regionPicker.alpha = 0.5
        }
    }
    
    @IBAction func onChangedDatePickerSwitch(_ sender: Any) {
        lockDatePickerSwitch(isLock: datePickerSwitch.isOn)
    }
    
    func lockDatePickerSwitch(isLock:Bool){
        findFromDatePicker.isUserInteractionEnabled = isLock
        findFromDatePicker.isEnabled = isLock
        findToDatePicker.isEnabled = isLock
        findToDatePicker.isUserInteractionEnabled = isLock
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("test prepare1")
        if let id = segue.identifier, id == "segueToNewsListVC"{
            if let newsListVC = segue.destination as? NewsListViweController{
                let findWord = toFindWordText.text == "" || toFindWordText.text == nil ? "" : toFindWordText.text
                if selectedArticleType == .TopHeadline{
                    // top headline
                    newsListVC.searchOption = SearchOptionData(_articleType: selectedArticleType, _toFindWord: findWord, _region: selectedRegion, _category: selectedCategory)
                    
                    
                }else{
                    // everything
                    let fromDate = dateFormat.string(from: findFromDatePicker.date)
                    let toDate = dateFormat.string(from: findToDatePicker.date)
                    newsListVC.searchOption = SearchOptionData(_articleType: selectedArticleType, _toFindWord: findWord, _fromDate: fromDate, _toDate: toDate, _language: selectedLanguage.converted)
                }
            }
        }
    }
    
    @IBAction func OnClickedSearch(_ sender: Any) {
        if selectedArticleType == .Everything{
            if toFindWordText.text == nil || toFindWordText.text == ""{
                let alertController = UIAlertController(title:"Notice", message: "In everything type, you shoud input any word to find", preferredStyle: .alert)
                                   alertController.addAction(UIAlertAction(title:"OK", style: .default))
                                   self.present(alertController, animated: true, completion: nil)
                return
            }
        }
        
        performSegue(withIdentifier: "segueToNewsListVC", sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
