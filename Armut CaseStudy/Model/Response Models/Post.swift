//
//  Post.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 23.10.2021.
//

import Foundation

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
