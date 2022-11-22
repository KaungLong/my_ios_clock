//
//  AlarmInfo.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/11/2.
//

import Foundation
import UserNotifications

//鬧鐘提醒 基本數係設置
struct AlarmInfo:Codable{
    var id = UUID()
    var date:Date = Date()
    var note:String = "鬧鐘"
    var noteLabel:String{
        if repeatDay == "從不"{
            return note
        }
        return note + ", " + repeatDay
    }
    var selectDays:Set<Day> = []
    var isEdit = false
    var repeatDay:String{
        switch selectDays{
        case [.Sat, .Sun]:
            return "週末"
        case [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]:
            return "每天"
        case [.Mon, .Tue, .Wed, .Thu, .Fri]:
            return "平日"
        case []:
            return "從不"
        default:
            let day = selectDays.sorted(by: {$0.rawValue < $1.rawValue}).map{$0.dayText}.joined(separator: " ")
            return day
        }
    }
    //每當變動switch時，新增或刪除提示
    var isOn: Bool = true{
        didSet{
            if isOn{
                if self.selectDays.isEmpty{
                    UserNotification.addNotificationRequest(alarm: self)
                    print("no weekdays")
                }else {
                    for dayInts in self.selectDays{
                        var dayInt:Int{
                            switch dayInts{
                                case .Sun: return 1
                                case .Mon: return 2
                                case .Tue: return 3
                                case .Wed: return 4
                                case .Thu: return 5
                                case .Fri: return 6
                                case .Sat: return 7
                            }
                        }
                        UserNotification.addNotificationRequest(alarm: self,days: dayInt)
                    }
                }
            }else{
                // 刪除推播
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(self.id.uuidString)"])
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(self.id.uuidString)"])
                print("test")
            }
        }
    }
}
