//
//  ServiceDetailVM.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 21.10.2021.
//

import Foundation
import Moya

protocol ServiceDetailDelegate {
    func fetched(_ error: Error?)
}

struct ServiceSpec {
    let text: String
    let icon : String
}

class ServiceDetailVM {
    // MARK: - Parameters
    private let networkManager = NetworkManager()
    var serviceDetail: ServiceDetail?
    var serviceSpecs = [ServiceSpec]()
    var delegate: ServiceDetailDelegate?
    
    /// Case  services provider
    private let caseProvider = MoyaProvider<CaseServices>()
    
    /// Get's the selected service's detail
    /// - Parameter id: Service id
    func getService(with id: Int) {
        networkManager.getServiceDetail(id) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let service):
                strongSelf.serviceDetail = service
                strongSelf.fillSpecs(service)
                strongSelf.delegate?.fetched(nil)
            case .failure(let error):
                strongSelf.delegate?.fetched(error)
            }
        }
    }
    
    /// Fill specific service's data.
    /// - Parameter service: Selected service
    private func fillSpecs(_ service: ServiceDetail) {
        if let pros = service.proCount {
            let proSpec = ServiceSpec(text: "\(pros) pros near you",
                                       icon: "serviceProfessional")
            serviceSpecs.append(proSpec)
        }
        let rating = ServiceSpec(text: "\(service.averageRating) average rating",
                                   icon: "serviceRating")
        serviceSpecs.append(rating)
        let jobsDone = ServiceSpec(text: "Last month \(service.completedJobsOnLastMonth) cleaning job completed cleaning job completed",
                                    icon: "serviceJobDone")
        serviceSpecs.append(jobsDone)
        let freeOfCharge = ServiceSpec(text: "Free of charge",
                                        icon: "serviceFreeUsage")
        serviceSpecs.append(freeOfCharge)
        let serviceGuaranteed = ServiceSpec(text: "Service Guaranteed",
                                             icon: "serviceGuarantee")
        serviceSpecs.append(serviceGuaranteed)
    }
}
