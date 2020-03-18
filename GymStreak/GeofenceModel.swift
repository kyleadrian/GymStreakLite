// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let GeofenceModel = try? newJSONDecoder().decode(GeofenceModel.self, from: jsonData)

import Foundation

// MARK: - GeofenceModel
struct GeofenceModel: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let errorType: String?
    let errorDetail: String?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case errorType
        case errorDetail
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let geofence: Geofence?
}

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

// MARK: - Boundary
struct Boundary: Codable {
    let radius: Int?
}
