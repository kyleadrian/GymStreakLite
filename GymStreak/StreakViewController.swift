//
//  StreakViewController.swift
//  GymTracker
//
//  Created by Kyle Wiltshire on 3/5/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import UIKit
import CoreLocation
import Pilgrim
import FSOAuth

class StreakViewController: UIViewController {
  @IBOutlet weak var addGymButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var workoutCountLabel: UILabel!
  @IBOutlet weak var timesLabel: UILabel!
  @IBOutlet weak var emojiLabel: UILabel!
  @IBOutlet weak var connectToFoursquareButton: UIButton!
  
  private let locationManager = CLLocationManager()
  private var token = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.requestAlwaysAuthorization()
    
    addGymButton.isHidden = true
    titleLabel.text = "👋 Welcome to GymStreak powered by Foursquare!"
    timesLabel.isHidden = true
    workoutCountLabel.isHidden  = true
    emojiLabel.isHidden = true
    
    let workoutCount = UserDefaults.standard.integer(forKey: "workoutCount")
    workoutCountLabel.text = String(workoutCount)
    
    switch workoutCount {
    case (1...5):
      emojiLabel.text = "🙂"
    case (6...10):
      emojiLabel.text = "😀"
    case _ where workoutCount > 10:
      emojiLabel.text = "💪"
    default:
      break
    }
  }
  
  @IBAction func signInWithFoursquare(_ sender: Any) {
    FSOAuth.authorizeUser(usingClientId: K.clientId, nativeURICallbackString: K.callback, universalURICallbackString: nil, allowShowingAppStore: false)
  }
  
  func handleURL(url: URL) {
    var errorCode: FSOAuthErrorCode = FSOAuthErrorCode.none
    guard let accessCode = FSOAuth.accessCode(forFSOAuthURL: url, error: &errorCode) else { return }
    FSOAuth.requestAccessToken(forCode: accessCode,
                               clientId: K.clientId,
                               callbackURIString: K.callback,
                               clientSecret: K.clientSecret) { (accessToken, completed, error) in
                                if let accessToken = accessToken, completed && error == .none {
                                  self.token = accessToken
                                  self.configureUI()
                                }
    }
  }
  
  func configureUI() {
    addGymButton.isHidden = false
    titleLabel.text = "You've been to the gym"
    timesLabel.text = "times"
    timesLabel.isHidden = false
    workoutCountLabel.isHidden  = false
    emojiLabel.isHidden = false
    connectToFoursquareButton.isHidden = true
    dismiss(animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let navVc = segue.destination as? UINavigationController {
      if let destinationVc = navVc.viewControllers.first as? GymsTableViewController {
        destinationVc.geofenceManager = GeofenceManager(accessToken: token)
      }
    }
  }
}
