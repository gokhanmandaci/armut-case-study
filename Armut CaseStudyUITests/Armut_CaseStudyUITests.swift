//
//  Armut_CaseStudyUITests.swift
//  Armut CaseStudyUITests
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import XCTest

class Armut_CaseStudyUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testPresentingASpecificService() {
        let app = XCUIApplication()
        app.launch()
        let clvservicesCollectionView = app.collectionViews["clvServices"]
        XCTAssertTrue(clvservicesCollectionView.exists)
        let element = clvservicesCollectionView.children(matching: .other).element(boundBy: 0)
        element.children(matching: .other).element(boundBy: 0).swipeUp()
        element.swipeUp()
        XCTAssertTrue(clvservicesCollectionView.cells["serviceCell0"].exists)
        clvservicesCollectionView.cells["serviceCell0"].children(matching: .other).element.children(matching: .other).element.tap()
    }
    
    func testPresentingABlogPost() {
        let app = XCUIApplication()
        app.launch()
        let clvservicesCollectionView = app.collectionViews["clvServices"]
        XCTAssertTrue(clvservicesCollectionView.exists)
        clvservicesCollectionView.children(matching: .other).element(boundBy: 0)
            .children(matching: .other).element(boundBy: 0)
            .children(matching: .other).element
            .children(matching: .other).element(boundBy: 0).swipeUp()
        clvservicesCollectionView.otherElements.containing(.staticText, identifier:"All services").element.swipeUp()
        XCTAssertTrue(app.staticTexts["Latests from the blog"].exists)
        clvservicesCollectionView/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells["popular0"].children(matching: .other).element.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
