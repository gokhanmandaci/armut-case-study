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
