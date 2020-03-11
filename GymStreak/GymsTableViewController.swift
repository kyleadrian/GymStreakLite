//
//  GymsTableViewController.swift
//  GymTracker
//
//  Created by Kyle Wiltshire on 3/5/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import UIKit

class GymsTableViewController: UITableViewController {
    var geofenceManager: GeofenceManager?
    
    let gymChains = [
        (name: "New York Sports Club", chainId: "55946538498e6a0fd536ca20"),
        (name: "Crunch Fitness", chainId:"556a2e68a7c8957d73d41de7"),
        (name: "Equinox", chainId:"556a28f8a7c8957d73d37328"),
        (name: "Blink Fitness", chainId:"556e56debd6a82902e28b74c"),
        (name: "24 Hour Fitness", chainId:"556ce426aceaff43eb04e8a0"),
        (name: "Planet Fitness", chainId:"556d0900aceaff43eb07f9d2"),
        (name: "YMCA", chainId:"5568ecb3a7c8a9cf8ec391f1"),
        (name: "CYC Fitness", chainId:"5568ecd3a7c8a9cf8ec393d8"),
        (name: "The Bay Club Company", chainId: "5568eed2a7c8a9cf8ec3d70c"),
        (name: "exhale", chainId:"5568f419a7c8a9cf8ec4837c"),
        (name: "SoulCycle", chainId:"5569f2cca7c8896abe7c4805"),
        (name: "Retro Fitness", chainId:"556a29ada7c8957d73d38580"),
        (name: "In-Shape", chainId:"556a2a42a7c8957d73d397c8"),
        (name: "LA Fitness", chainId: "556d0900aceaff43eb07f9de"),
        (name: "Anytime Fitness", chainId: "556e0690a7c82e6b724e70b4"),
        (name: "Orange Theory Fitness", chainId:"556e5adcbd6a82902e2942a9"),
        (name: "Weight Watchers", chainId: "5900a4d306fb602077776630"),
        (name: "Barry's Bootcamp", chainId: "5a95bb1895da0c40425406dc")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geofenceManager?.delegate = self
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymChains.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gym = gymChains[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Gym", for: indexPath)
        cell.textLabel?.text = gym.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gym = gymChains[indexPath.row]
        geofenceManager?.createVenueGeofence(for: gym)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GymsTableViewController: GeofenceManagerDelegate {
    func didSucceed(status: String) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Gym Tracker", message: "\(status)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
            self.present(ac, animated: true)
        }
    }
    
    func didFail(error: String) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Gym Tracker", message: "\(error)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}
