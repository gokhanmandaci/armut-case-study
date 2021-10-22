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
    var serviceDetail: ServiceDetail?
    var serviceSpecs = [ServiceSpec]()
    var delegate: ServiceDetailDelegate?
    
    /// Case  services provider
    private let caseProvider = MoyaProvider<CaseServices>()
    
    func getService(with id: Int) {
        caseProvider.request(.detail(id)) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
//                if response.statusCode > 400 {
//                    Helper.showBasicServerError()
                // strongSelf.delegate?.fetched(error)
//                }
                let decoder = JSONDecoder()
                do {
                    let serviceDetailResponse = try decoder.decode(ServiceDetail.self, from: response.data)
                    strongSelf.serviceDetail = serviceDetailResponse
                    strongSelf.fillSpecs(serviceDetailResponse)
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
