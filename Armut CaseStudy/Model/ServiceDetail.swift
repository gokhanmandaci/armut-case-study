//
//  ServiceDetail.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation

// MARK: - ServiceDetail
/// Keep imageURL and proCount as optionals here also.
struct ServiceDetail: Codable {
    let id, serviceID: Int
    let name, longName: String
    let imageURL: String?
    let proCount: Int?
    let averageRating: Double
    let completedJobsOnLastMonth: Int

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case name
        case longName = "long_name"
        case imageURL = "image_url"
        case proCount = "pro_count"
        case averageRating = "average_rating"
        case completedJobsOnLastMonth = "completed_jobs_on_last_month"
    }
}
