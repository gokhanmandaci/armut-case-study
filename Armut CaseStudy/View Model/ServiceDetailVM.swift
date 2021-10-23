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
    
    /// Get's the selected service's detail
    /// - Parameter id: Service id
    func getService(with id: Int) {
        serviceDetail = ServiceDetail(id: 608, serviceID: 608, name: "Özel Ders", longName: "Özel Ders Özel Ders Özel Ders Özel Ders Özel Ders Özel Ders", imageURL: "https://cdn.armut.com/images/services/00608-ozel-ders.jpg", proCount: 1234, averageRating: 3.2, completedJobsOnLastMonth: 123123)
        fillSpecs(serviceDetail!)
        delegate?.fetched(nil)
//        caseProvider.request(.detail(id)) { [weak self] result in
//            guard let strongSelf = self else { return }
//            switch result {
//            case .success(let response):
//                // Simply checks over 400 http response.
//                if response.statusCode > 400 {
//                    strongSelf.delegate?.fetched(NetworkManager.shared.checkResponse(response))
//                }
//                let decoder = JSONDecoder()
//                do {
//                    let serviceDetailResponse = try decoder.decode(ServiceDetail.self, from: response.data)
//                    strongSelf.serviceDetail = serviceDetailResponse
//                    strongSelf.fillSpecs(serviceDetailResponse)
//                    strongSelf.delegate?.fetched(nil)
//                } catch {
//                    let error = NetworkManager.shared.parsingError("Get Service")
//                    strongSelf.delegate?.fetched(error)
//                }
//            case .failure(let error):
//                strongSelf.delegate?.fetched(error)
//            }
//        }
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
