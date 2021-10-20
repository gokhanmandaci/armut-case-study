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
    var services = [[String: [Any]]]()
    var delegate: ServicesDelegate?
    
    /// Case  services provider
    private let caseProvider = MoyaProvider<CaseServices>()
    
    func fetch() {
        caseProvider.request(.home) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
//                if response.statusCode > 400 {
//                    Helper.showBasicServerError()
                // strongSelf.delegate?.fetched(error)
//                }
                let decoder = JSONDecoder()
                do {
                    let servicesResponse = try decoder.decode(Services.self, from: response.data)
                    strongSelf.services.append(["Main Header" : []])
                    strongSelf.services.append(["All services" : servicesResponse.allServices])
                    strongSelf.services.append(["Popular these days" : servicesResponse.popular])
                    strongSelf.services.append(["Latests from the blog" : servicesResponse.posts])
                    strongSelf.delegate?.fetched(nil)
                } catch {
//                    Helper.showBasicServerError()
                    strongSelf.delegate?.fetched(error)
                }
            case .failure(let error):
                //                    Helper.showServerNotRespondingError()
                strongSelf.delegate?.fetched(error)
            }
        }
    }
}
