//
//  NetworkManagerTests.swift
//  Armut CaseStudyTests
//
//  Created by Gökhan Mandacı on 23.10.2021.
//

import XCTest
import Moya
@testable import Armut_CaseStudy

class NetworkManagerTests: XCTestCase {
    // MARK: - Parameters
    private var networkManager: NetworkManager!
    /// This will force immediate response
    private let stubbingProvider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
    
    /// Custom endpoint closure for server error cases
    let serverErrorEndpointClosure = { (target: CaseServices) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(500, "500 Error".data(using: .utf8)!) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testGetAllServicesSuccess() {
        let expectation = self.expectation(description: "AllServicesRequest")
        networkManager = NetworkManager()
        networkManager.getAllServices { result in
            switch result {
            case .success(_):
                XCTAssert(true, "Request returns success as expected.")
            default:
                XCTAssert(false, "Request expected to success but failed.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetAllServicesDataParsingSuccess() {
        let provider = MoyaProvider<CaseServices>()
        let expectation = self.expectation(description: "AllServicesRequest")
        provider.request(.home) { result in
            switch result {
            case .success(let servicesResponse):
                let decoder = JSONDecoder()
                let servicesResponse = try? decoder.decode(Services.self, from: servicesResponse.data)
                if servicesResponse != nil {
                    XCTAssert(true, "Successfuly parsed.")
                } else {
                    XCTAssert(true, "Cannot be parsed to Services type.")
                }
            default:
                XCTAssert(false, "Request expected to success but failed.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetAllServicesServerError() {
        let serverErrorProvider = MoyaProvider<CaseServices>(endpointClosure: serverErrorEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        serverErrorProvider.request(.home) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 500 {
                    XCTAssert(true, "Returned 500 as expected.")
                } else {
                    XCTAssert(false, "Expected to return 500 but failed.")
                }
            default:
                XCTAssert(false)
            }
        }
    }
    
    func testServiceByIdSuccess() {
        let expectation = self.expectation(description: "ServiceById")
        networkManager = NetworkManager()
        networkManager.getServiceDetail(59) { result in
            switch result {
            case .success(_):
                XCTAssert(true, "Request returns success as expected.")
            default:
                XCTAssert(false, "Request expected to success but failed.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testServiceByIdDataParsingSuccess() {
        let provider = MoyaProvider<CaseServices>()
        let expectation = self.expectation(description: "ServiceById")
        provider.request(.detail(59)) { result in
            switch result {
            case .success(let servicesResponse):
                let decoder = JSONDecoder()
                let servicesResponse = try? decoder.decode(ServiceDetail.self, from: servicesResponse.data)
                if servicesResponse != nil {
                    XCTAssert(true, "Successfuly parsed.")
                } else {
                    XCTAssert(false, "Cannot be parsed to Services type.")
                }
            default:
                XCTAssert(false, "Request expected to success but failed.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testServiceByIdDataParsingError() {
        let provider = MoyaProvider<CaseServices>()
        let expectation = self.expectation(description: "ServiceById")
        provider.request(.detail(-59)) { result in
            switch result {
            case .success(let servicesResponse):
                let decoder = JSONDecoder()
                let servicesResponse = try? decoder.decode(ServiceDetail.self, from: servicesResponse.data)
                if servicesResponse == nil {
                    XCTAssert(true, "Cannot be parsed as expected.")
                } else {
                    XCTAssert(false, "Parsed to Services type.")
                }
            default:
                XCTAssert(false, "Request expected to success but failed.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testServiceByIdServerError() {
        let serverErrorProvider = MoyaProvider<CaseServices>(endpointClosure: serverErrorEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        serverErrorProvider.request(.detail(1)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 500 {
                    XCTAssert(true, "Returned 500 as expected.")
                } else {
                    XCTAssert(false, "Expected to return 500 but failed.")
                }
            default:
                XCTAssert(false)
            }
        }
    }
    
}
