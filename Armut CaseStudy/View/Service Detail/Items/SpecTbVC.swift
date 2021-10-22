//
//  SpecTbVC.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 22.10.2021.
//

import UIKit
import SwiftSVG

class SpecTbVC: UITableViewCell {
    // MARK: - Parameters
    static let reuseId = "SpecTbVReuseId"
    
    // MARK: - Outlets
    @IBOutlet weak var vwIcon: SVGView!
    @IBOutlet weak var lblSpecText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - Methods
extension SpecTbVC {
    func setCell(_ spec: ServiceSpec) {
        vwIcon.SVGName = spec.icon
        lblSpecText.text = spec.text
    }
}
