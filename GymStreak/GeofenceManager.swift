//
//  GeofenceManager.swift
//  GymTracker
//
//  Created by Kyle Wiltshire on 3/5/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import Foundation

protocol GeofenceManagerDelegate: AnyObject {
    func didSucceed(status: String)
    func didFail(error: String)
}

class GeofenceManager {
    private var accessToken: String
    private var clientID = K.clientId
    var delegate: GeofenceManagerDelegate?
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func createVenueGeofence(for gym: Gym) {
        var geofenceUrl = URLComponents(string: "https://api.foursquare.com")
        geofenceUrl?.path = "/v2/apps/\(clientID)/geofences/add"
        geofenceUrl?.queryItems = [
            URLQueryItem(name: "v", value: "20190224"),
            URLQueryItem(name: "oauth_token", value: accessToken),
            URLQueryItem(name: "name", value: gym.name),
            URLQueryItem(name: "radius", value: "100"),
            URLQueryItem(name: "chainId", value: gym.chainId),
            URLQueryItem(name: "dwellTime", value: "20")
        ]
        
        guard let url = geofenceUrl?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                let apiResponse = try? JSONDecoder().decode(GeofenceModel.self, from: data)
                guard let statusCode = apiResponse?.meta?.code else { return }
                if statusCode == 200 {
                    self?.delegate?.didSucceed(status: "Success")
                } else {
                    self?.delegate?.didFail(error: "\(apiResponse?.meta?.errorDetail ?? "Unknown Error. Please try again later.")")
                }
            }
        }.resume()
    }
}
