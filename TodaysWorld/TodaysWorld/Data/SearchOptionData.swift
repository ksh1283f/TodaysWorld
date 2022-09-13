//
//  SearchOptionData.swift
//  BusBooking
//
//  Created by Seunghyeon Kang on 5/21/20.
//  Copyright © 2020 Seunghyeon Kang. All rights reserved.
//

import Foundation

enum E_Language:String, CaseIterable{
    case None            = ""
    case Arabic          = "ar"
    case German          = "de"
    case EnglishUS       = "en"
    case EnglishUK       = "en-GB"
    case EnglishAu       = "en-AU"
    case EnglishCa        = "en-CA"
    case EnglishIn       = "en-IN"
    case French          = "fr"
    case FrenchCa        = "fr-CA"
    case Spanish         = "es"
    case SpanishMex      = "es-MX"
    case Hebrew          = "he"
    case Italian         = "it"
    case Dutch           = "nl"
    case Portuguese      = "pt"
    case PortugueseBr    = "pt-BR"
    case Russian         = "ru"
    case Swedish         = "sv"// se
    case Norwegian       = "nb"//no
    case Chinese         = "zh"
    case ChineseSim      = "zh-Hans"
    case ChineseTrad     = "zh-Hant"
    case ChineseHK       = "zh-HK"
}
extension E_Language{
    var converted:String{
        switch self {
        case .None
            ,.EnglishUK
            ,.EnglishAu
            ,.EnglishCa
            ,.EnglishIn:
            return "en"
        case .French
            ,.FrenchCa:
            return "fr"
        case .Spanish
            ,.SpanishMex:
            return "es"
        case .Portuguese
            ,.PortugueseBr:
            return "pt"
        case .Chinese
            ,.ChineseHK
            ,.ChineseSim
            ,.ChineseTrad:
            return "zh"
        case .Norwegian:
            return "no"
        case .Swedish:
            return "se"
        default:
            return self.rawValue
        }
    }
    
    var getStringType:String{
        var result = ""
        switch self {
        case .EnglishUS:
            result = "🇺🇸"
        case .EnglishUK:
            result = "🇬🇧"
        case .ChineseHK:
            result = "🇭🇰"
        case .EnglishCa:
            result = "🇨🇦"
        case .EnglishAu:
            result = "🇦🇺"
        case .French, .FrenchCa:
            result = "🇫🇷"
        case .Spanish:
            result = "🇪🇸"
        case .SpanishMex:
            result = "🇲🇽"
        case .Portuguese:
            result = "🇵🇹"
        case .PortugueseBr:
            result = "🇧🇷"
        case .Chinese, .ChineseSim:
            result = "🇨🇳"
        case .ChineseTrad:
            result = "🇹🇼"
        case .Norwegian:
            result = "🇳🇴"
        case .Swedish:
            result = "🇸🇪"

        default:
            result = ""
        }
        
        return result + self.rawValue
    }
}
//source
enum E_Region:String, CaseIterable{
    case None = ""
    case Argentina = "ar"
    case Australia = "au"
    case Austria = "at"
    case Belgium = "be"
    case Brazil = "br"
    case Bulgaria = "bg"
    case Canada = "ca"
    case China = "cn"
    case Colombia = "co"
    case Cuba = "cu"
    case CzechRepublic = "cz"
    case Egypt = "eg"
    case France = "fr"
    case Germany = "de"
    case Greece = "gr"
    case HongKong = "hk"
    case Hungary = "hu"
    case India = "in"
    case Indonesia = "id"
    case Ireland = "ie"
    case Israel = "il"
    case Italy = "it"
    case Japan = "jp"
    case Latvia = "lv"
    case Lithuania = "lt"
    case Malaysia = "my"
    case Mexico = "mx"
    case Morocco = "ma"
    case Netherlands = "nl"
    case NewZealand = "nz"
    case Nigeria = "ng"
    case Norway = "no"
    case Philippines = "ph"
    case Poland = "pl"
    case Portugal = "pt"
    case Romania = "ro"
    case Russia = "ru"
    case SaudiArabia = "sa"
    case Serbia = "rs"
    case Singapore = "sg"
    case Slovakia = "sk"
    case Slovenia = "si"
    case SouthAfrica = "za"
    case SouthKorea = "kr"
    case Sweden = "se"
    case Switzerland = "ch"
    case Taiwan = "tw"
    case Thailand = "th"
    case Turkey = "tr"
    case UAE = "ae"
    case Ukraine = "ua"
    case UnitedKingdom = "gb"
    case UnitedStates = "us"
    case Venuzuela =  "ve"
    
    var getStringType: String{
        var result = ""
        switch self{
            case .Argentina:
                result = "🇦🇷"
            case .Australia:
                result = "🇦🇺"
            case .Austria:
                result = "🇦🇹"
            case .Belgium:
                result = "🇧🇪"
            case .Brazil:
                result = "🇧🇷"
            case .Bulgaria:
                result = "🇧🇬"
            case .Canada:
                result = "🇨🇦"
            case .China:
                result = "🇨🇳"
            case .Colombia:
                result = "🇨🇴"
            case .Cuba:
                result = "🇨🇺"
            case .CzechRepublic:
                result = "🇨🇿"
            case .Egypt:
                result = "🇪🇬"
            case .France:
                result = "🇫🇷"
            case .Germany:
                result = "🇩🇪"
            case .Greece:
                result = "🇬🇷"
            case .HongKong:
                result = "🇭🇰"
            case .Hungary:
                result = "🇭🇺"
            case .India:
                result = "🇮🇳"
            case .Indonesia:
                result = "🇮🇩"
            case .Ireland:
                result = "🇮🇪"
            case .Israel:
                result = "🇮🇱"
            case .Italy:
                result = "🇮🇹"
            case .Japan:
                result = "🇯🇵"
            case .Latvia:
                result = "🇱🇻"
            case .Lithuania:
                result = "🇱🇹"
            case .Malaysia:
                result = "🇲🇾"
            case .Mexico:
                result = "🇲🇽"
            case .Morocco:
                result = "🇲🇦"
            case .Netherlands:
                result = "🇳🇱"
            case .NewZealand:
                result = "🇳🇿"
            case .Nigeria:
                result = "🇳🇬"
            case .Norway:
                result = "🇳🇴"
            case .Philippines:
                result = "🇵🇭"
            case .Poland:
                result = "🇵🇱"
            case .Portugal:
                result = "🇵🇹"
            case .Romania:
                result = "🇷🇴"
            case .Russia:
                result = "🇷🇺"
            case .SaudiArabia:
                result = "🇸🇦"
            case .Serbia:
                result = "🇷🇸"
            case .Singapore:
                result = "🇸🇬"
            case .Slovakia:
                result = "🇸🇰"
            case .Slovenia:
                result = "🇸🇮"
            case .SouthAfrica:
                result = "🇿🇦"
            case .SouthKorea:
                result = "🇰🇷"
            case .Sweden:
                result = "🇸🇪"
            case .Switzerland:
                result = "🇨🇭"
            case .Taiwan:
                result = "🇹🇼"
            case .Thailand:
                result = "🇹🇭"
            case .Turkey:
                result = "🇹🇷"
            case .UAE:
                result = "🇦🇪"
            case .Ukraine:
                result = "🇺🇦"
            case .UnitedKingdom:
                result = "🇬🇧"
            case .UnitedStates:
                result = "🇺🇸"
            case .Venuzuela:
                result = "🇻🇪"
            default:
                result = "🏳️"
        }
        
        return result
    }
}

enum E_Category:String, CaseIterable{
    case None = ""
    case Business = "business"
    case Entertainment = "entertainment"
    case General = "general"
    case Health = "health"
    case Science = "science"
    case Sports = "sports"
    case Technology = "technology"
}

enum E_ArticleType:Int{
    case TopHeadline = 0
    case Everything = 1
}

class SearchOptionData{
    // common
    var articleType:E_ArticleType
    var toFindWord:String?
    
    // everything
    var fromDate:String?
    var toDate:String?
    var language:String?
    
    // top headline
    var region:E_Region
    var category:E_Category
    
    init(_articleType:E_ArticleType, _toFindWord:String?, _fromDate:String = "", _toDate:String = "", _language:String = "", _region:E_Region = .None, _category:E_Category = .None){
        articleType = _articleType
        toFindWord = _toFindWord
        if articleType == .Everything{
            fromDate = _fromDate
            toDate = _toDate
            language = _language
            region = _region
            category = _category
            if _region != .None || _category != .None{
                print("[\(articleType)] invalid value entered")
            }
        }else{
            region = _region
            category = _category
            
            if _fromDate != "" || _toDate != "" || _language != ""{
                print("[\(articleType)] invalid value entered")
            }
        }
    }
}
