//
//  FailedRequestVC.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 22.10.2021.
//

import UIKit

protocol FailedRequestsDelegate {
    func retry()
}

class FailedRequestVC: UIViewController {
    // MARK: - Parameters
    static let strId = "FailedRequestViewStrId"
    var delegate: FailedRequestsDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var vwTopConstraint: NSLayoutConstraint!
    
    // MARK: - Actions
    @IBAction func btnYesAction(_ sender: Any) {
        delegate?.retry()
    }
    @IBAction func btnNoAction(_ sender: Any) {
        animate(to: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Prepare for animation
        view.backgroundColor = .clear
        vwTopConstraint.constant = Helper.getHeight()
        view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animate(to: true)
    }
    
    /// Animate the popup view. Show or hide.
    /// Dismiss if visible is false
    /// - Parameter visible: Decides show or hide
    private func animate(to visible: Bool) {
        var topConstraint = Helper.getHeight()
        var color = UIColor.clear
        if visible {
            topConstraint = Helper.getHeight() / 4
            color = UIColor.black.withAlphaComponent(0.3)
        }
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.2,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.01,
                       options: .curveEaseIn) { [self] in
            vwTopConstraint.constant = topConstraint
            view.backgroundColor = color
            view.layoutIfNeeded()
        } completion: { [weak self] _ in
            if !visible {
                self?.dismiss(animated: false)
            }
        }

    }
}
