//
//  AppDelegate.swift
//  PushNotifications
//
//  Created by John Regner on 12/11/16.
//  Copyright © 2016 iOS-Connect. All rights reserved.
//

import UIKit
import UserNotifications
import PusherSwift

let pusherKey = "5637213a207393e799e6"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let pusher = Pusher(key: pusherKey)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 10.0, *) {
            pusher.connect()
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // actions based on whether notifications were authorized or not
            }
        } else {
            // Fallback on earlier versions
        }

        application.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pusher.nativePusher().register(deviceToken: deviceToken)
        pusher.nativePusher().subscribe(interestName: "donuts")
    }

}

