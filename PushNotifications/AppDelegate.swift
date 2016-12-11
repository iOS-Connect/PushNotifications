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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let pushManager = PushManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        pushManager.firstLaunch()
        pushManager.askPermissions()
        application.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushManager.registrationSuccessFull(token: deviceToken)
    }

}

class PushManager {
    static let pusherKey = "5637213a207393e799e6"
    let pusher = Pusher(key: PushManager.pusherKey)

    func firstLaunch() {
        pusher.connect()
    }

    func askPermissions() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // actions based on whether notifications were authorized or not
            }
        } else {

        }

    }

    func registrationSuccessFull(token: Data) {
        pusher.nativePusher().register(deviceToken: token)
        pusher.nativePusher().subscribe(interestName: "donuts")
    }
}

