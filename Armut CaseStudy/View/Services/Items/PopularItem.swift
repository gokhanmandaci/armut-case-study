//
//  PopularItemView.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit

class PopularItem: UICollectionViewCell {
    // MARK: - Parameters
    static let reuseId = "popularItemViewReuseId"
    
    // MARK: - Outlets
    @IBOutlet weak var imgService: DownloaderImageView!
    @IBOutlet weak var lblServiceName: UILabel!
    
}

// MARK: - Methods
extension PopularItem {
    func setCell(_ service: Service) {
        if let imgUrl = service.imageURL {
            imgService.dlImage(urlString: imgUrl)
        }
        
        lblServiceName.text = service.longName
    }
}