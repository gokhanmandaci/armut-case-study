//
//  AllServices.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation

// MARK: - Services
struct Services: Codable {
    let allServices, popular: [Service]
    let posts: [Post]

    enum CodingKeys: String, CodingKey {
        case allServices = "all_services"
        case popular, posts
    }
}

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

// MARK: - Post
/// I used imageURL and proCount as optionals. Service
/// has no null values for posts. So let's keep them like this
/// as a different case.
struct Post: Codable {
    let title, category: String
    let imageURL: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case title, category
        case imageURL = "image_url"
        case link
    }
}
