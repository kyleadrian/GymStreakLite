//
//  GeofenceManager.swift
//  GymTracker
//
//  Created by Kyle Wiltshire on 3/5/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import Foundation
import UIKit

protocol GeofenceManagerDelegate: AnyObject {
    func didSucceed(status: String)
    func didFail(status: String)
}

class GeofenceManager {
    private var accessToken: String
    private var clientID = K.clientId
    private weak var delegate: GeofenceManagerDelegate?
    
    init(accessToken: String, delegate: GeofenceManagerDelegate) {
        self.accessToken = accessToken
        self.delegate = delegate
    }
    
    func createVenueGeofence(for chainId: String) {
        let geofenceUrl = "https://api.foursquare.com/v2/apps/\(clientID)/geofences/add?v=20190224&oauth_token=\(accessToken)&name=MyGymGeofence&radius=100&chainId=\(chainId)&dwellTime=\(20)"
        guard let url = URL(string: geofenceUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let res = response as? HTTPURLResponse {
                if (200...299).contains(res.statusCode) {
                    self?.delegate?.didSucceed(status: "Success")
                } else {
                    self?.delegate?.didFail(status: "Error")
                }
            }
        }.resume()
    }
}
