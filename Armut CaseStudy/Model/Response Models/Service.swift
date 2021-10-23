//
//  Service.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 23.10.2021.
//

import Foundation

// MARK: - Service
/// Service can be used for both all services and popular
/// sections.
struct Service: Codable {
    let id, serviceID: Int
    let name, longName: String
    let imageURL: String?
    let proCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case name
        case longName = "long_name"
        case imageURL = "image_url"
        case proCount = "pro_count"
    }
}
