//
//  NetworkManager.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation
import Moya

class NetworkManager {
    /// Singleton instance
    static let shared: NetworkManager = NetworkManager()
    
    enum NetworkError: Error {
        case badRequest
        case authState
        case notFound
        case serverError
        case unexpectedError
    }
    
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
