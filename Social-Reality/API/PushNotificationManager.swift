//
//  PushNotificationManager.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/26/21.
//

import Foundation
import Firebase
import FirebaseMessaging
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func registerForPushNotifications() {
        
        print("Registering for notifications")
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay, .announcement]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        Messaging.messaging().delegate = self
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
        
    }
    
    func updateFirestorePushTokenIfNeeded() {
        guard let token = Messaging.messaging().fcmToken, let id = Auth0.uid else {
            return
        }
        AppDelegate.fcmTOKEN = token
        Query.update.user(id: id, data: ["fcmToken": token]) { result in
            print(result)
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        updateFirestorePushTokenIfNeeded()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
}

