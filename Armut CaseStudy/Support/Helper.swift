//
//  Helper.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit

class Helper {
    /// Gets device width
    /// - Returns: CGFLoat
    class func getWidth() -> CGFloat {
        return CGFloat(AppConstants.shared.deviceWidth)
    }
    
    /// Gets device height
    /// - Returns: CGFLoat
    class func getHeight() -> CGFloat {
        return CGFloat(AppConstants.shared.deviceHeight)
    }
    
    /// Sets deviceWidth and deviceHeight parameters for further use.
    /// - Parameters:
    ///   - width: Device width
    ///   - height: Device height
    class func setDeviceBounds(_ width: Int, height: Int) {
        AppConstants.shared.deviceWidth = width
        AppConstants.shared.deviceHeight = height
    }
}
