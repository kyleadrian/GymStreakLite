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
    func didFail(error: String)
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
            if let data = data {
                let apiResponse = try? JSONDecoder().decode(Welcome.self, from: data)
                guard let statusCode = apiResponse?.meta?.code else { return }
                if (200...299).contains(statusCode) {
                    self?.delegate?.didSucceed(status: "Success")
                } else {
                    self?.delegate?.didFail(error: "\(apiResponse?.meta?.errorDetail ?? "")")
                }
            }
        }.resume()
    }
}
