//
//  GetBusInfoViewController.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/18/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
import UIKit


class GetBusInfoViewController: UIViewController,XMLParserDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityNames.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityNames[row]
    }
    // Capture the picker view selection
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // This method is triggered whenever the user makes a change to the picker selection.
       // The parameter named row and component represents what was selected.
        
   }
    @IBAction func OnClickedBtnNext(_ sender: Any) {
        print("selected city: ")
    }
    
    
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var busNumberPicker: UIPickerView!
    @IBOutlet weak var btnNext: UIButton!
    
    var cityCode:Int = -1
    var cityName:String = ""
    var elementName:String = ""
    var cityDataDic:[Int:String] = [:]
    var cityNames:[String] = []
    
    let publicKey:String = "?ServiceKey=xNGoQ7cLCtzWMU2Tcr9aIWVyq%2Fkg7y%2FzIRJGVXAIvYlAwSuprfj2cpOEm5Pqog7ee4cIY2Z%2FesjG836WUZPeQCw%3D%3D"
    let baseUrl:String = "http://openapi.tago.go.kr/openapi/service/BusLcInfoInqireService/"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self
        
        GetCityDataList()
        
        
    }
    
    func GetCityDataList(){
        let getCityCodeList:String = "getCtyCodeList"
        let url:String = baseUrl+getCityCodeList+publicKey
        
        if let parser = XMLParser(contentsOf: URL(string: url)!){
            parser.delegate = self
            parser.parse()
            
            cityNames = Array(cityDataDic.values)
            print(cityDataDic)
        }
        
        
    }
    
    // 1 <item>
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elementName = elementName
        if elementName == "item" {
            cityCode = -1
            cityName = ""
        }
    }

    // 2 </item>
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let cityData:CityData = CityData(code: cityCode, name: cityName)
            cityDataDic[cityData.cityCode] = cityData.cityName
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "citycode" {
                cityCode = Int(data)!
//                bookTitle += data
            } else if self.elementName == "cityname" {
                cityName = data
//                bookAuthor += data
            }
        }
    }
}
