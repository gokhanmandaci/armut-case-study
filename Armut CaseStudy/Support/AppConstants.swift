//
//  AppConstants.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation

class AppConstants {
    /// Singleton
    static let shared: AppConstants = AppConstants()
    
    /// Root URL
    let root = "https://my-json-server.typicode.com/"
    /// Holds device width
    var deviceWidth = 0
    /// Holds device height
    var deviceHeight = 0
}
