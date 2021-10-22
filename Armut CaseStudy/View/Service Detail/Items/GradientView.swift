//
//  GradientView.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 21.10.2021.
//

import UIKit

// MARK: - Gradient View
/// We are animating shadow image on the picture in the
/// service detail page. So we need this subclass to GradientView
/// to make UIView handle the animation operation for us.
/// Reference: https://stackoverflow.com/a/17558724
/// I'm using this old technique in my other apps also.
class GradientView: UIView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let gradientLayer = self.layer as? CAGradientLayer else {
            return;
        }

        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = self.bounds
        gradientLayer.shouldRasterize = true
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
