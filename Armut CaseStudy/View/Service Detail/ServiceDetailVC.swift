//
//  ServiceDetailVC.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 22.10.2021.
//

import UIKit

class ServiceDetailVC: UIViewController {
    // MARK: - Parameters
    private let imageView = UIImageView()
    private let gradientView = GradientView()
    private let lblName = UILabel()
    /// Header height calculation multiplier
    private let headerImageHeightMultiplier = 0.6
    private var headerImageHeight: CGFloat = 0.0
    private let appearance = UINavigationBarAppearance()
    /// Navbar + Status bar (including notch). We will update this.
    private var topHeight: CGFloat = 64
    /// Sets max pull value for tableview
    private let maxPullTreshold: CGFloat = 80
    private let serviceDetailVM = ServiceDetailVM()
    var service: Service?
    
    // MARK: - Outlets
    @IBOutlet weak var tbvService: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        let specNib = UINib(nibName: Nibs.SpecTbV, bundle: nil)
        tbvService.register(specNib, forCellReuseIdentifier: SpecTbVC.reuseId)
        tbvService.estimatedRowHeight = 60
        tbvService.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 15, *) {
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = UIColor.clear
            appearance.shadowImage = nil
            setAppearance()
        }
        
        serviceDetailVM.delegate = self
        serviceDetailVM.getService(with: 608)
        if let service = service {
            serviceDetailVM.delegate = self
            serviceDetailVM.getService(with: service.id)
        }
    }
}

// MARK: - Methods
extension ServiceDetailVC {
    /// Set's navigation bar appearence
    /// - Parameter height: Base height calculated from scroll
    private func setAppearance(_ height: CGFloat? = nil) {
        if let height = height {
            let labelAlpha: CGFloat = (height / 100) * 2
            let navBarAlpha: CGFloat = 1 - labelAlpha
            lblName.alpha = labelAlpha
            appearance.titleTextAttributes = [.foregroundColor: UIColor.green.withAlphaComponent(navBarAlpha)]
            appearance.backgroundColor = .white.withAlphaComponent(navBarAlpha)
        } else {
            lblName.alpha = 1.0
            appearance.titleTextAttributes = [.foregroundColor: UIColor.green.withAlphaComponent(0.0)]
            appearance.backgroundColor = .white.withAlphaComponent(0.0)
        }
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupLayout() {
        let navBarHeight = navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarHeight()
        headerImageHeight = Helper.getWidth() * headerImageHeightMultiplier
        topHeight = (navBarHeight! + statusBarHeight)
        // Subtract navigation bar height. We want our image located right
        // under the top view. +20 is the padding.
        let offSet = headerImageHeight - topHeight
        tbvService.contentInset = UIEdgeInsets(top: offSet - 1, left: 0, bottom: 0, right: 0)
        navigationItem.title = ""

        imageView.frame = CGRect(x: 0, y: 0, width: Helper.getWidth(), height: headerImageHeight)
        imageView.image = UIImage.init(named: "wedding")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        lblName.frame = .zero
        lblName.text = service?.longName ?? ""
        lblName.sizeToFit()
        lblName.translatesAutoresizingMaskIntoConstraints = false
        let leftAnchor = lblName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let rightAnchor = lblName.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 20)
        let widthAnchor = lblName.widthAnchor.constraint(equalToConstant: Helper.getWidth() - 40)
        let bottomAnchor = lblName.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
        
        lblName.textColor = UIColor.white
        lblName.font = UIFont.boldSystemFont(ofSize: 26)
        lblName.numberOfLines = 2
        
        gradientView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height)
        imageView.addSubview(gradientView)
        imageView.addSubview(lblName)
        
        view.addConstraints([leftAnchor, rightAnchor, widthAnchor, bottomAnchor])
        view.layoutIfNeeded()
    }
}

// MARK: - UITableView Methods
extension ServiceDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceDetailVM.serviceSpecs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpecTbVC.reuseId, for: indexPath) as? SpecTbVC else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        let spec = serviceDetailVM.serviceSpecs[indexPath.row]
        cell.setCell(spec)
        
        return cell
    }
    
    // Using grouped style with no section header.
    // Removed header in section.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView(frame: CGRect(x: 0, y: 0, width: Helper.getWidth(), height: 300))
        return serviceDetailVM.serviceSpecs.count > 0 ? footer : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 500
    }
}

// MARK: - UITableView as UIScrollView Methods
extension ServiceDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = headerImageHeight - (scrollView.contentOffset.y + headerImageHeight)
        let height = min(max(y, 0), headerImageHeight + topHeight + maxPullTreshold)
        imageView.frame.size.height = height + topHeight
        if height < topHeight {
            setAppearance(height)
        } else {
            setAppearance()
        }
    }
}

// MARK: - Service Detail View Model Methods
extension ServiceDetailVC: ServiceDetailDelegate {
    func fetched(_ error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            navigationItem.title = serviceDetailVM.serviceDetail?.name ?? ""
            lblName.text = serviceDetailVM.serviceDetail?.longName ?? ""
            tbvService.reloadData()
        }
    }
}
