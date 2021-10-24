//
//  NetworkManager.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation
import Moya

class NetworkManager {
    // MARK: - Parameters
    // We can use MoyaProvider<CaseServices> for this project.
    // But for common use like with multiple repos and protocols.
    // I implemented it as MultiTarget. Mock test can be done now.
    /// Moya Provider.
    private let provider: MoyaProvider<MultiTarget>
    
    /// Network error enum. Can be enhanced.
    enum NetworkError: Error {
        case badRequest
        case authState
        case notFound
        case serverError
        case unexpectedError
    }
    
    // MARK: - Init
    init(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()) {
        self.provider = provider
    }
    
    // Below two functions can be used under a generic requester
    // in a real world app.
    /// Get all services for home page.
    /// - Parameter completionHandler: Returns Services or Error
    func getAllServices(_ completionHandler: @escaping (Result<Services, Error>) -> Void) {
        provider.request(MultiTarget(CaseServices.home)) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                // Simply checks over 400 http response.
                if response.statusCode > 400 {
                    completionHandler(.failure(strongSelf.checkResponse(response)))
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let servicesResponse = try decoder.decode(Services.self, from: response.data)
                    completionHandler(.success(servicesResponse))
                } catch {
                    let error = strongSelf.parsingError("Get All Services")
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// Get a specific service with an id.
    /// - Parameter completionHandler: Returns ServiceDetail or Error
    func getServiceDetail(_ id: Int, _ completionHandler: @escaping (Result<ServiceDetail, Error>) -> Void) {
        provider.request(MultiTarget(CaseServices.detail(id))) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                // Simply checks over 400 http response.
                if response.statusCode > 400 {
                    completionHandler(.failure(strongSelf.checkResponse(response)))
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let serviceResponse = try decoder.decode(ServiceDetail.self, from: response.data)
                    completionHandler(.success(serviceResponse))
                } catch {
                    let error = strongSelf.parsingError("Get Service Detail")
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

// MARK: - Helper Methods
extension NetworkManager {
    /// Simple service error checker
    /// - Parameter response: Moya response
    /// - Returns: Related error type.
    func checkResponse(_ response: (Response)) -> Error {
        switch response.statusCode {
        case 400:
            return NetworkError.badRequest
        case 401:
            return NetworkError.authState
        case 500:
            return NetworkError.serverError
        default:
            return NetworkError.unexpectedError
        }
    }
    
    /// Create a parsing error for detecting model or parse errors.
    /// - Parameter service: Track the service with name
    /// - Returns: Parsing error.
    func parsingError(_ service: String) -> Error {
        let error = NSError(domain: service + "parsing error", code: 5001)
        return error as Error
    }
    
    /// Prints the data as json for debug purposes.
    /// - Parameter data: Moya response data.
    func printJSON(_ data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(json)
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
