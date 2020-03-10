// Welcome.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let meta: Meta?
    let notifications: [Notification]?
    let response: Response?
}

// Meta.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let meta = try? newJSONDecoder().decode(Meta.self, from: jsonData)

import Foundation

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// Notification.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notification = try? newJSONDecoder().decode(Notification.self, from: jsonData)

import Foundation

// MARK: - Notification
struct Notification: Codable {
    let type: String?
    let item: Item?
}

// Item.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let item = try? newJSONDecoder().decode(Item.self, from: jsonData)

import Foundation

// MARK: - Item
struct Item: Codable {
    let unreadCount: Int?
}

// Response.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let response = try? newJSONDecoder().decode(Response.self, from: jsonData)

import Foundation

// MARK: - Response
struct Response: Codable {
    let geofence: Geofence?
}

// Geofence.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let geofence = try? newJSONDecoder().decode(Geofence.self, from: jsonData)

import Foundation

// MARK: - Geofence
struct Geofence: Codable {
    let type, name, id: String?
    let venueIDS: [String]?
    let boundary: Boundary?
    let dwellTime: Int?

    enum CodingKeys: String, CodingKey {
        case type, name, id
        case venueIDS = "venueIds"
        case boundary, dwellTime
    }
}

// Boundary.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let boundary = try? newJSONDecoder().decode(Boundary.self, from: jsonData)

import Foundation

// MARK: - Boundary
struct Boundary: Codable {
    let radius: Int?
}

// JSONSchemaSupport.swift

