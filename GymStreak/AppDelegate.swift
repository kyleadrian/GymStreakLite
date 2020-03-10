//
//  AppDelegate.swift
//  GymStreak
//
//  Created by Kyle Wiltshire on 3/10/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import UIKit

import UIKit
import Pilgrim

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PilgrimManagerDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PilgrimManager.shared().configure(withConsumerKey: K.clientId, secret: K.clientSecret, delegate: self, completion: nil)
        PilgrimManager.shared().start()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handle visit: Visit) {
    }
    
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handle geofenceEvents: [GeofenceEvent]) {
        for event in geofenceEvents {
            if event.eventType == .dwell {
                let visitCount = UserDefaults.standard.integer(forKey: "visitCount")
                visitCount == 0 ? UserDefaults.standard.set(1, forKey: "visitCount") : UserDefaults.standard.set(visitCount + 1, forKey: "visitCount")
            }
        }
    }
}



