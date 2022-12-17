//
//  LocalNotificationManager.swift
//  GameBook
//
//  Created by Hasan Uysal on 16.12.2022.
//

import UIKit

protocol LocalNotificationManagerProtocol {
    func create()
}

final class LocalNotificationManager: LocalNotificationManagerProtocol {
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    func create() {
        requestNotificationAuthorization()
        sendNotification()
    }
    
    private func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { _, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    private func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Games Book"
        notificationContent.body = NSLocalizedString("App language was changed. Tap to open app!" , comment: "")
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "GameBookNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
