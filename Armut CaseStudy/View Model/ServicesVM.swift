//
//  ServicesVM.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation
import Moya

protocol ServicesDelegate {
    func fetched(_ error: Error?)
}

class ServicesVM {
    // MARK: - Parameters
    private let networkManager = NetworkManager()
    var services = [[String: [Any]]]()
    var delegate: ServicesDelegate?
    
    /// Case  services provider
    private let caseProvider = MoyaProvider<CaseServices>()
    
    func fetch() {
        networkManager.getAllServices { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let services):
                strongSelf.services.append(["Main Header" : []])
                strongSelf.services.append(["All services" : services.allServices])
                strongSelf.services.append(["Popular these days" : services.popular])
                strongSelf.services.append(["Latests from the blog" : services.posts])
                strongSelf.delegate?.fetched(nil)
            case .failure(let error):
                strongSelf.delegate?.fetched(error)
            }
        }
    }
}
