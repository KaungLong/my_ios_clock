//
//  UserNotification.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/11/2.
//

import Foundation
import NotificationCenter
import AVFoundation

//通知管理
class UserNotification{
    var contentHandler: ((UNNotificationContent) -> Void)?
    
    static func addNotificationRequest(alarm: AlarmInfo,days:Int = 0) {
        
        let current = UNUserNotificationCenter.current()
        //        current.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Clock"
        content.subtitle = "Alarm"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("123.wav"))
        //        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: alarm.date)
        let minute = calendar.component(.minute, from: alarm.date)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        if days != 0{
            dateComponents.weekday = days
        }
  
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        current.add(request) { error in
            if(error == nil){
                print("successfully")
            }else{
                print("error")
            }
        }
    }
}
