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
import AdSupport

class StreakViewController: UIViewController {
    @IBOutlet weak var addGymButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var visitCountLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var connectToFoursquareButton: UIButton!
    
    private let locationManager = CLLocationManager()
    private let clientId = K.clientId
    private let callback = K.callback // set or find it here - https://foursquare.com/developers/apps
    private var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        
        addGymButton.isHidden = true
        titleLabel.text = "👋 Welcome to GymStreak powered by Foursquare!"
        timesLabel.isHidden = true
        visitCountLabel.isHidden  = true
        emojiLabel.isHidden = true
        
        let visitCount = UserDefaults.standard.integer(forKey: "visitCount")
        visitCountLabel.text = String(visitCount)
        
        switch visitCount {
        case (1...5):
            emojiLabel.text = "🙂"
        case (6...10):
            emojiLabel.text = "😀"
        case _ where visitCount > 10:
            emojiLabel.text = "💪"
        default:
            break
        }
    }
    
    @IBAction func signInWithFoursquare(_ sender: Any) {
        let fsqAuthClient = FoursquareAuthClient(clientId: clientId, callback: callback , delegate: self)
        fsqAuthClient.authorize(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVc = segue.destination as? UINavigationController {
            if let destinationVc = navVc.viewControllers.first as? GymsTableViewController {
                guard let token = token else { return }
                destinationVc.geofenceManager = GeofenceManager(accessToken: token)
            }
        }
    }
}

extension StreakViewController: FSQAuthClientDelegate {
    func FSQAuthClientDidSucceed(accessToken: String) {
        token = accessToken
        addGymButton.isHidden = false
        titleLabel.text = "You've been to the gym"
        timesLabel.text = "times"
        timesLabel.isHidden = false
        visitCountLabel.isHidden  = false
        emojiLabel.isHidden = false
        connectToFoursquareButton.isHidden = true
        dismiss(animated: true)
    }
    
    func FSQAuthClientDidFail(error: Error) {
        print(error)
    }
}
