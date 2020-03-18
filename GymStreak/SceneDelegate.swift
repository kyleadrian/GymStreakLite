//
//  SceneDelegate.swift
//  GymStreak
//
//  Created by Kyle Wiltshire on 3/10/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
  }
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let urlContext = URLContexts.first {
      let vc = self.window!.rootViewController as! UINavigationController
      let streakVC = vc.viewControllers.first as! StreakViewController
      streakVC.handleURL(url: urlContext.url)
    }
  }
}
