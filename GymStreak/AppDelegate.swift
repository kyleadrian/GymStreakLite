//
//  AppDelegate.swift
//  GymStreak
//
//  Created by Kyle Wiltshire on 3/10/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import Pilgrim

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PilgrimManagerDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    PilgrimManager.shared().configure(withConsumerKey: K.clientId, secret: K.clientSecret, delegate: self, completion: nil)
    PilgrimManager.shared().start()
    return true
  }
  
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handle visit: Visit) {
  }
  
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handle geofenceEvents: [GeofenceEvent]) {
    for event in geofenceEvents {
      if event.eventType == .dwell {
        let workoutCount = UserDefaults.standard.integer(forKey: "workoutCount")
        workoutCount == 0 ? UserDefaults.standard.set(1, forKey: "workoutCount") : UserDefaults.standard.set(workoutCount + 1, forKey: "workoutCount")
      }
    }
  }
  
}



