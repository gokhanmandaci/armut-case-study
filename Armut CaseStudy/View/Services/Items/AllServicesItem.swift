//
//  AllServicesItem.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit
import SwiftSVG

class AllServicesItem: UICollectionViewCell {
    // MARK: - Parameters
    static let reuseId = "allServicesItemReuseId"
    
    // MARK: - Outlets
    @IBOutlet weak var stkService: UIStackView!
    @IBOutlet weak var lblServiceName: UILabel!
}

// MARK: - Methods
extension AllServicesItem {
    func setCell(_ service: Service) {
        if stkService.arrangedSubviews.count <= 1 {
            let serviceImage = UIView(SVGNamed: "\(service.id)")
            serviceImage.translatesAutoresizingMaskIntoConstraints = false
            serviceImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
            serviceImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
            serviceImage.clipsToBounds = true
            stkService.insertArrangedSubview(serviceImage, at: 0)
        }
        
        // I split the words with two names for
        // to make UI look like the design.
        lblServiceName.text = service.name.components(separatedBy: " ").first ?? ""
    }
}
