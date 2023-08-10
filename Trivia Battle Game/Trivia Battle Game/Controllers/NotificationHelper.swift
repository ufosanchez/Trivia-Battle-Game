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
            }
        }
    }
    
    

}
