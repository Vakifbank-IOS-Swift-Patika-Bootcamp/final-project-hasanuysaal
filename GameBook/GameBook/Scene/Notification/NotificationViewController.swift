//
//  NotificationViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 16.12.2022.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { _, error in
            if let error = error {
                print(error)
            }
        }
    }
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Games Book"
        notificationContent.body = "Hey, you can show popular games now!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "GameBookNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
}
