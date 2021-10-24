//
//  ServiceDetailVC.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 22.10.2021.
//

import UIKit
import Hero
import SVProgressHUD

class ServiceDetailVC: UIViewController {
    // MARK: - Parameters
    // UI Elements
    private let imageView = DownloaderImageView()
    private let gradientView = GradientView(alpha: 0.6)
    private let lblName = UILabel()
    private var navBarColor: UIColor = .white
    // Calculation elements
    /// Header height calculation multiplier
    private let headerImageHeightMultiplier = 0.6
    private var headerImageHeight: CGFloat = 0.0
    private let appearance = UINavigationBarAppearance()
    /// Navbar + Status bar (including notch). We will update this.
    private var topHeight: CGFloat = 64
    /// Sets max pull value for tableview
    private let maxPullTreshold: CGFloat = 80
    // View Model Instance
    private let serviceDetailVM = ServiceDetailVM()
    // Preload
    var service: Service?
    var heroId: String?
    /// Storyboard id
    static let strId = "ServiceDetailStrId"
    
    // MARK: - Outlets
    @IBOutlet weak var tbvService: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        if let service = service {
            serviceDetailVM.delegate = self
            serviceDetailVM.getService(with: service.id)
        }
    }
    
    // MARK: - Actions
    @IBAction func btnContinueAction(_ sender: Any) {
        guard let failedView = UIStoryboard(name: Storyboards.FailedRequestView, bundle: nil)
            .instantiateViewController(withIdentifier: FailedRequestVC.strId) as? FailedRequestVC else { return }
        failedView.modalPresentationStyle = .overCurrentContext
        failedView.delegate = self
        present(failedView, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 15, *) {
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = UIColor.clear
            appearance.shadowImage = nil
            setAppearance()
        }
        
        if let heroId = heroId {
            self.hero.isEnabled = true
            imageView.hero.id = heroId
        }
    }
}

// MARK: - Methods
extension ServiceDetailVC {
    /// Sets UI and UI elements and parameters
    private func setup() {
        navigationItem.title = service?.name ?? ""
        
        if traitCollection.userInterfaceStyle == .dark {
            navBarColor = UIColor(red: 31 / 255,
                                  green: 31 / 255,
                                  blue: 31 / 255,
                                  alpha: 0.3)
        }
        
        setSizeDependentElements()
        setupLayout()
        
        let specNib = UINib(nibName: Nibs.SpecTbV, bundle: nil)
        tbvService.register(specNib, forCellReuseIdentifier: SpecTbVC.reuseId)
        tbvService.estimatedRowHeight = 60
        tbvService.rowHeight = UITableView.automaticDimension
    }
    
    /// Set's navigation bar appearence
    /// - Parameter height: Base height calculated from scroll
    private func setAppearance(_ height: CGFloat? = nil) {
        if let height = height {
            let labelAlpha: CGFloat = (height / 100) * 2
            let navBarAlpha: CGFloat = 1 - labelAlpha
            lblName.alpha = labelAlpha
            appearance.titleTextAttributes = [.foregroundColor: UIColor.green.withAlphaComponent(navBarAlpha)]
            appearance.backgroundColor = navBarColor.withAlphaComponent(navBarAlpha)
        } else {
            lblName.alpha = 1.0
            appearance.titleTextAttributes = [.foregroundColor: UIColor.green.withAlphaComponent(0.0)]
            appearance.backgroundColor = navBarColor.withAlphaComponent(0.0)
        }
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupLayout() {
        let offSet = headerImageHeight - topHeight
        tbvService.contentInset = UIEdgeInsets(top: offSet - 1, left: 0, bottom: 0, right: 0)

        imageView.frame = CGRect(x: 0, y: 0, width: Helper.getWidth(), height: headerImageHeight)
        imageView.image = UIImage.init(named: "wedding")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.dlImage(urlString: service?.imageURL)
        let imgRightAnchor = imageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        view.addSubview(imageView)
        
        lblName.frame = .zero
        lblName.text = service?.longName ?? ""
        lblName.sizeToFit()
        lblName.translatesAutoresizingMaskIntoConstraints = false
        let leftAnchor = lblName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let rightAnchor = lblName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        let bottomAnchor = lblName.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
        lblName.textColor = UIColor.white
        var fontSize: CGFloat = 26
        if UIDevice.current.userInterfaceIdiom == .pad {
            fontSize = 34
        }
        lblName.font = UIFont.boldSystemFont(ofSize: fontSize)
        lblName.numberOfLines = 2
        
        gradientView.frame = imageView.frame
        imageView.addSubview(gradientView)
        imageView.addSubview(lblName)
        view.addConstraints([leftAnchor, rightAnchor, bottomAnchor, imgRightAnchor])
    }
    
    private func setSizeDependentElements() {
        let navBarHeight = navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarHeight()
        headerImageHeight = Helper.getWidth() * headerImageHeightMultiplier
        topHeight = (navBarHeight! + statusBarHeight)
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
        var dimen: CGFloat = 500
        if UIDevice.current.userInterfaceIdiom == .pad {
            dimen = 700
        }
        return dimen
    }
}

// MARK: - UITableView as UIScrollView Methods
extension ServiceDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = headerImageHeight - (scrollView.contentOffset.y + headerImageHeight)
        let height = min(max(y, 0), headerImageHeight + topHeight + maxPullTreshold)
        imageView.frame.size.height = height + topHeight
        gradientView.frame.size.height = imageView.frame.height
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
        SVProgressHUD.dismiss()
        if error != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                guard let failedView = UIStoryboard(name: Storyboards.FailedRequestView, bundle: nil)
                    .instantiateViewController(withIdentifier: FailedRequestVC.strId) as? FailedRequestVC else { return }
                failedView.modalPresentationStyle = .overCurrentContext
                failedView.delegate = self
                present(failedView, animated: false)
            }
        } else {
            navigationItem.title = serviceDetailVM.serviceDetail?.name ?? ""
            lblName.text = serviceDetailVM.serviceDetail?.longName ?? ""
            tbvService.reloadData()
        }
    }
}

// MARK: - Failed Requests View Methods
extension ServiceDetailVC: FailedRequestsDelegate {
    func retry() {
        if let service = service {
            SVProgressHUD.show()
            serviceDetailVM.getService(with: service.id)
        }
    }
}
