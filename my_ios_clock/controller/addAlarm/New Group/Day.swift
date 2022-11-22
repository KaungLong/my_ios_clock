//
//  Day.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/31.
//

import Foundation

enum Day:Int, Codable, CaseIterable{
    case Sun = 0,Mon,Tue,Wed,Thu,Fri,Sat
    
    var dayString:String{
        switch self{
            case .Sun: return "星期日"
            case .Mon: return "星期一"
            case .Tue: return "星期二"
            case .Wed: return "星期三"
            case .Thu: return "星期四"
            case .Fri: return "星期五"
            case .Sat: return "星期六"
        }
    }
    
    var dayText:String{
        switch self{
            case .Sun: return "Sun"
            case .Mon: return "Mon"
            case .Tue: return "Tue"
            case .Wed: return "Wed"
            case .Thu: return "Thu"
            case .Fri: return "Fri"
            case .Sat: return "Sat"
        }
    }
    
}
