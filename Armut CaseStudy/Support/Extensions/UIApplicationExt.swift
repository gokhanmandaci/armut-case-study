//
//  UIApplicationExt.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 22.10.2021.
//

import UIKit

extension UIApplication {
    /// Reference: https://stackoverflow.com/a/68989580
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    
    /// Simple way to get status bar height
    /// - Returns: StatusBar height CGFloat
    func statusBarHeight() -> CGFloat {
        return keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
