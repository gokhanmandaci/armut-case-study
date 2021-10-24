//
//  CaseServices.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation
import Moya

enum CaseServices {
    case home
    case detail(_ id: Int)
}

/// Main service abstraction. Can be used as multiple repos.
extension CaseServices: TargetType {
    var baseURL: URL {
        return URL(string: AppConstants.shared.root)!
    }
    
    var path: String {
        switch self {
        case .home:
            return Endpoints.home
        case .detail(let id):
            return Endpoints.detail + "\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["content-type": "application/json"]
    }
}
