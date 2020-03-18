//
//  GymsTableViewController.swift
//  GymTracker
//
//  Created by Kyle Wiltshire on 3/5/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import UIKit

struct Gym: Decodable {
  let name: String
  let chainId: String
}

class GymsTableViewController: UITableViewController {
  var geofenceManager: GeofenceManager?
  var gyms: [Gym] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    geofenceManager?.delegate = self

    let dataFileUrl = Bundle.main.url(forResource: "Gyms", withExtension: "plist")
    if let plistData = try? Data(contentsOf: dataFileUrl!) {
      gyms = (try? PropertyListDecoder().decode([Gym].self, from: plistData)) ?? []
    }
  }
  
  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return gyms.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let gym = gyms[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Gym", for: indexPath)
    cell.textLabel?.text = gym.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let gym = gyms[indexPath.row]
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
