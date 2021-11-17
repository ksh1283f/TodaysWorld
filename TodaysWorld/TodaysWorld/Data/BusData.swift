//
//  BusData.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 4/16/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation
//http://openapi.tago.go.kr/openapi/service/TrainInfoService/getCtyCodeList?ServiceKey=서비스키
//
//응답 메시지
//<?xml version="1.0" encoding="UTF-8" standalone="true"?>
//-<response>-<header><resultCode>00</resultCode><resultMsg>NORMAL SERVICE.</resultMsg></header>-<body>-<items>-<item><citycode>11</citycode><cityname>서울특별시</cityname></item>-<item><citycode>21</citycode><cityname>부산광역시</cityname></item>-<item><citycode>22</citycode><cityname>대구광역시</cityname></item>-<item><citycode>23</citycode><cityname>인천광역시</cityname></item>-<item><citycode>24</citycode><cityname>광주광역시</cityname></item>-<item><citycode>25</citycode><cityname>대전광역시</cityname></item>-<item><citycode>26</citycode><cityname>울산광역시</cityname></item>-<item><citycode>31</citycode><cityname>경기도</cityname></item>-<item><citycode>32</citycode><cityname>강원도</cityname></item>-<item><citycode>33</citycode><cityname>충청북도</cityname></item>-<item><citycode>34</citycode><cityname>충청남도</cityname></item>-<item><citycode>35</citycode><cityname>전라북도</cityname></item>-<item><citycode>36</citycode><cityname>전라남도</cityname></item>-<item><citycode>37</citycode><cityname>경상북도</cityname></item>-<item><citycode>38</citycode><cityname>경상남도</cityname></item></items></body></response>


//# Python 샘플 코드 #
//
//
//from urllib2 import Request, urlopen
//from urllib import urlencode, quote_plus
//
//url = 'http://openapi.tago.go.kr/openapi/service/BusLcInfoInqireService/getCtyCodeList'
//queryParams = '?' + urlencode({ quote_plus('ServiceKey') : '서비스키', quote_plus('파라미터영문명') : '파라미터기본값' })
//
//request = Request(url + queryParams)
//request.get_method = lambda: 'GET'
//response_body = urlopen(request).read()
//print response_body

//
//  ViewController.swift
//  StudyTabelView
//
//  Created by Seunghyeon Kang on 1/27/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

// <json data examples>
//{
//  "status": "ok",
//  "totalResults": 32,
//  -"articles": [
//  +{ … },
//  +{ … },
//  +{ … },
//  -{
//      -"source": {
//      "id": null,
//      "name": "Yna.co.kr"
//      },
//      "author": "김효정",
//      "title": "\"트렌디한 노래도 우리 색으로\"…뉴트로로 돌아온 젝스키스 - 연합뉴스",
//      "description": "\"트렌디한 노래도 우리 색으로\"…뉴트로로 돌아온 젝스키스, 김효정기자, 문화뉴스 (송고시간 2020-01-28 14:43)",
//      "url": "https://www.yna.co.kr/view/AKR20200128103900005",
//      "urlToImage": "https://img8.yna.co.kr/etc/inner/KR/2020/01/28/AKR20200128103900005_01_i_P4.jpg",
//      "publishedAt": "2020-01-28T05:43:00Z",
//      "content": "(=) = \" ' ' , . .\"()\r\n 23 1 1990 .\r\n (, , , ) 28 1 ' '(ALL FOR YOU) . 6 ' ' YG 2 4 , 4        .\r\n \" \"(), \" . \"() .\r\n ' ' 5 . \r\n ' ' 1990 (R&amp;B) , ' ' . \" \" .\r\n . , .\r\n '' . . \"          \" '' .\r\n \" . , . .\"()\r\n \" , .\"() \r\n . YG . \r\n \" . , \" .\r\n \" . 6 \" \"( ) . , \"           .\r\n . '' … [+116 chars]"
//    },

// sample get news api
//import UIKit
//
//class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var tableView: UITableView!
//    var newsArray: Array<Dictionary<String, Any>>?
//
//    func GetNews(){
//        let task = URLSession.shared.dataTask(with: URL(string:"https://newsapi.org/v2/top-headlines?country=kr&apiKey=80f590ba8a10480ea5e20c27fb77cb84")!) { (data, response, error) in
//            // 1. 받아온 data를 json 파싱
//            // 2. 파싱된 데이터를 newsArray에 넣어주기
//            // 3. 초기화된 newsArray를 화면에 뿌려줄수 있게 테이블 뷰에서 리로드
//            if let dataJson = data{
//                // json parsing
//                do{
//                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
//                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
//                    self.newsArray = articles
//
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }catch{
//                    print("parsing error!")
//                }
//            }
//        }
//        task.resume()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let news = self.newsArray{   // newsArray가 있으면 그 배열의 개수를 반환
//            print("news count: \(news.count)")
//            return news.count
//        }else{  // 없으면 0 반환
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //1. 임의의 셀 만들기
//        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "type")
//        //cell.textLabel?.text = "\(indexPath.row)"
//
//        // 2. 스토리보드 + id
//        // 2-1. newsArray에 따라 ui 갱신
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellType1", for: indexPath) as! CellType1
//        let index = indexPath.row
//        if let news = self.newsArray{
//            let article = news[index]
//            if let row = article as? Dictionary<String, Any>{
//                if let title = row["title"] as? String{
//                    cell.ContentLabel.text = title
//                }
//            }
//
//        }
////        cell.ContentLabel.text = "\(indexPath.row)"
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Clicked: \(indexPath.row)")
//        // 값 보내기
////        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)   // finding mainStoryboard
////        if let controller = storyboard.instantiateViewController(identifier: "DetailNewsView") as? DetailNewsView{
////            let idx = indexPath.row
////            if let news = newsArray{
////                // urlToImage, description
////                if let article = news[idx] as? Dictionary<String, Any>{
////                    if let desc = article["description"] as? String{
////                        controller.newsDescription = desc
////                    }
////                    if let urlImage = article["urlToImage"] as? String{
////                        controller.newsImageURL = urlImage
////                    }
////                }
////            }
////            //화면 이동은 수동으로
//////            showDetailViewController(controller, sender: nil)
////        }
//    }
//
//    //1. 디테일(상세) 화면 만들기
//    //2. 값을 보내기
//    // 2-1. tableView delegate pattern(original)
//    // 2-2. storyboard's segue
//    //3. 화면 이동
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // 1. find targetted storyboard
//        if let id = segue.identifier, id == "SegueToDetail"{
//            if let detailView = segue.destination as? DetailNewsView{
//                if let idx = tableView.indexPathForSelectedRow?.row{
//                    if let news = newsArray{
//                        // Initialize target news's article(use index)
//                        if let article = news[idx] as? Dictionary<String, Any>{
//                            // imageurl
//                            if let imageUrl = article["urlToImage"] as? String{
//                                detailView.newsImageURL = imageUrl
//                                print(imageUrl)
//                            }
//                            // description
//                            if let desc = article["description"] as? String{
//                                detailView.newsDescription = desc
//                                print(desc)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        // navigation title text 변경
//
//        // 뉴스 받아오기
//        GetNews()
//    }
//}


class BusData{
//    nodeid    정류소ID    30    1    DJB8001793ND    정류소ID
//    nodenm    정류소명    30    1    북대전농협    정류소명
//    routeid    노선ID    30    1    DJB30300002ND    노선ID
//    routeno    노선번호    30    1    5    노선번호
//    routetp    노선유형    10    1    마을버스    노선유형
//    arrprevstationcnt    도착예정버스 남은 정류장 수    3    1    15    도착예정버스 남은 정류장 수
//    vehicletp    도착예정버스 차량유형    10    1    저상버스    도착예정버스 차량유형
//    arrtime    도착예정버스 도착예상시간[초]    5    1    816    도착예정버스 도착예상시간[초]
    let nodeid:String
    let nodenm:String
    let routeid:String
    let routeno:Int
    let routetp:String
    let arrprevstationcnt:Int
    let vehicletp:String
    let arrtime:Int
    let citycode:Int
    
    init(_nodeid:String, _nodenm:String, _routeid:String,_routeno:Int, _routetp:String, _arrprevstationcnt:Int, _vehicletp:String,_arrtime:Int,_citycode:Int) {
        nodeid = _nodeid
        nodenm = _nodenm
        routeid = _routeid
        routeno = _routeno
        routetp = _routetp
        arrprevstationcnt = _arrprevstationcnt
        vehicletp = _vehicletp
        arrtime = _arrtime
        citycode = _citycode
    }
}
