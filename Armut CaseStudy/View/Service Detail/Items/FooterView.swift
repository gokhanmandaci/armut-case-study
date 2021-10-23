//
//  FooterView.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 22.10.2021.
//

import UIKit

class FooterView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var lblItemOne: UILabel!
    @IBOutlet weak var lblItemTwo: UILabel!
    @IBOutlet weak var lblItemThree: UILabel!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - setup
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        
        var color = UIColor(red: 204 / 255,
                            green: 204 / 255,
                            blue: 204 / 255,
                            alpha: 1.0)
        if traitCollection.userInterfaceStyle == .light {
            color = UIColor(red: 31 / 255,
                            green: 31 / 255,
                            blue: 31 / 255,
                            alpha: 0.3)
        }
        
        lblItemOne.layer.borderColor = color.cgColor
        lblItemOne.layer.borderWidth = 1
        lblItemTwo.layer.borderColor = color.cgColor
        lblItemTwo.layer.borderWidth = 1
        lblItemThree.layer.borderColor = color.cgColor
        lblItemThree.layer.borderWidth = 1
        
        addSubview(view)
    }
    
    /// Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
