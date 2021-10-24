//
//  AllServicesItem.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit

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
        var dimen: CGFloat = 30
        if UIDevice.current.userInterfaceIdiom == .pad {
            dimen = 60
        }
        if stkService.arrangedSubviews.count <= 1 {
            let serviceImage = UIImageView()
            serviceImage.image = UIImage(named: "\(service.id)")
            serviceImage.contentMode = .scaleAspectFill
            serviceImage.translatesAutoresizingMaskIntoConstraints = false
            serviceImage.widthAnchor.constraint(equalToConstant: dimen).isActive = true
            serviceImage.heightAnchor.constraint(equalToConstant: dimen).isActive = true
            serviceImage.clipsToBounds = true
            stkService.insertArrangedSubview(serviceImage, at: 0)
        }
        
        // I split the words with two names for
        // to make UI look like the design.
        lblServiceName.text = service.name.components(separatedBy: " ").first ?? ""
    }
}
