//
//  ServicesHeader.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit

class ServicesHeader: UICollectionReusableView {
    // MARK: - Parameters
    static let reuseId = "servicesHeaderReuseId"
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.text = "Hizmet piş\nağzıma düş"
        #warning("TODO: Fix auto layout warning in the console.")
    }
}
