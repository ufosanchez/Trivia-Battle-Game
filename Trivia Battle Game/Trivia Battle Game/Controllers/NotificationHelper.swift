//
//  NotificationHelper.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-20.
//

import Foundation
import UserNotifications

class NotificationHelper : ObservableObject {
    
    static let instance = NotificationHelper()
    
    func requestAuthorization(){
        let options : UNAuthorizationOptions = [.alert, .sound, .badge ]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR : \(error)")
            } else{
                print("SUCCESS")
                NotificationHelper.instance.playAgainNotification()
            }
        }
    }
    
    func playAgainNotification(){
        print("send notification play again")
        let content = UNMutableNotificationContent()
        content.title = "Trivia Battle Game"
        content.subtitle = "Come and play with us again!"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func addEnergyNotification(){
        print("send notification add energy")
        let content = UNMutableNotificationContent()
        content.title = "Trivia Battle Game"
        content.subtitle = "We just added Energy!"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }

}
