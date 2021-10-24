//
//  ServicesVC.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit
import SVProgressHUD
import SafariServices
import Hero

class ServicesVC: UICollectionViewController {
    // MARK: - Parameters
    private let servicesVM = ServicesVM()
    private let headerHeightMultiplier = 1.8
    private let leftAndRigthSpacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Set device boundaries for later and easy use.
        Helper.setDeviceBounds(Int(view.bounds.width),
                               height: Int(view.bounds.height))
        
        setup()
        
        servicesVM.delegate = self
        SVProgressHUD.show()
        servicesVM.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Methods
extension ServicesVC {
    /// Setup page layout, registrations of UI elements
    private func setup() {
        registerNibs()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: leftAndRigthSpacing,
                                           bottom: 0,
                                           right: leftAndRigthSpacing)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.accessibilityIdentifier = "clvServices"
    }
    
    /// Register necessary nibs
    private func registerNibs() {
        /// Main header registration
        let nibHeader: UINib = UINib(nibName: Nibs.ServicesHeader, bundle: nil)
        collectionView!.register(nibHeader,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ServicesHeader.reuseId)
        
        /// All Services registration
        let allServiceItem = UINib(nibName: Nibs.AllServicesItemView, bundle: nil)
        collectionView!.register(allServiceItem,
                                 forCellWithReuseIdentifier: AllServicesItem.reuseId)
        
        /// Popular Services registration
        let horizontalListItem = UINib(nibName: Nibs.HorizontalListView, bundle: nil)
        collectionView!.register(horizontalListItem,
                                 forCellWithReuseIdentifier: HorizontalList.reuseId)
    }
    
    /// Navigates to service detail page
    private func showService(_ service: Service?, _ heroId: String? = nil) {
        guard let serviceDetail = UIStoryboard(name: Storyboards.ServiceDetail,
                                               bundle: nil)
                .instantiateViewController(withIdentifier: ServiceDetailVC.strId) as? ServiceDetailVC else { return }
        serviceDetail.service = service
        serviceDetail.heroId = heroId
        if heroId == nil {
            navigationController?.hero.isEnabled = false
        } else {
            navigationController?.hero.isEnabled = true
        }
        navigationController?.pushViewController(serviceDetail, animated: true)
    }
}

// MARK: - UICollectionView Methods
extension ServicesVC: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionView DataSource Methods
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return servicesVM.services.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let values = servicesVM.services[section].values.first {
            if section <= 1 {
                return values.count
            } else {
                return 1
            }
        }
        return 0
    }
    
    // MARK: - Below functions manage cells.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// Check types before decide which type of cell to draw.
        /// We have service type and post type.
        if let serviceItems = servicesVM.services[indexPath.section].values.first {
            if let serviceItem = serviceItems[indexPath.row] as? Service {
                /// First all services and then horizontal lists
                if indexPath.section == 1 {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllServicesItem.reuseId,
                                                                        for: indexPath) as? AllServicesItem else { return UICollectionViewCell() }
                    cell.accessibilityIdentifier = "serviceCell\(indexPath.row)"
                    cell.setCell(serviceItem)
                    return cell
                }
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalList.reuseId,
                                                                    for: indexPath) as? HorizontalList else { return UICollectionViewCell() }
                cell.delegate = self
                if let popularServices = serviceItems as? [Service] {
                    cell.setCell(for: popularServices)
                }
                return cell
            } else if serviceItems[indexPath.row] is Post {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalList.reuseId,
                                                                    for: indexPath) as? HorizontalList else { return UICollectionViewCell() }
                cell.delegate = self
                if let posts = serviceItems as? [Post] {
                    cell.setCell(for: posts)
                }
                return cell
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var popularHeight: CGFloat = 140
        var blogHeight: CGFloat = 200
        var divider: CGFloat = 4
        if UIDevice.current.userInterfaceIdiom == .pad {
            divider = 8
            popularHeight = 190
            blogHeight = 250
        }
        if indexPath.section == 1 {
            // Calculate width dynamically
            let dimen = (Helper.getWidth() - ((3 * 10) + (2 * 20))) / divider
            return CGSize(width: dimen, height: dimen)
        } else {
            /// 40 is left 20 and right 20 with this way we handle inner collection view invalid sizes.
            /// Section insets will be inherited. Also has an effect on scroll performance.
            let width = collectionView.frame.width - leftAndRigthSpacing * 2
            if indexPath.section == 2 {
                return CGSize(width: width, height: popularHeight)
            } else {
                return CGSize(width: width, height: blogHeight)
            }
        }
    }
    
    // MARK: - Below functions manage headers.
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                 withReuseIdentifier: ServicesHeader.reuseId,
                                                                                 for: indexPath)
                return headerView
            } else {
                if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                withReuseIdentifier: SectionHeader.reuseId,
                                                                                for: indexPath) as? SectionHeader {
                    var sectionOneSize: CGFloat = 14
                    var otherSectionsSize: CGFloat = 18
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        sectionOneSize = 22
                        otherSectionsSize = 26
                    }
                    
                    if indexPath.section == 1 {
                        header.lblTitle.font = UIFont.boldSystemFont(ofSize: sectionOneSize)
                    } else {
                        header.lblTitle.font = UIFont.boldSystemFont(ofSize: otherSectionsSize)
                    }
                    header.lblTitle.text = servicesVM.services[indexPath.section].keys.first ?? ""
                    return header
                }
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            if let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: SectionFooter.reuseId,
                                                                            for: indexPath) as? SectionFooter {
                return footer
            }
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionView Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: Helper.getWidth(), height: Helper.getWidth() * headerHeightMultiplier)
        } else if section == 1 {
            return CGSize(width: Helper.getWidth(), height: 50)
        } else {
            return CGSize(width: Helper.getWidth(), height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == servicesVM.services.count - 1 {
            return CGSize(width: Helper.getWidth(), height: 100)
        }
        return .zero
    }
    
    // MARK: - UICollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let service = servicesVM.services[indexPath.section].values.first?[indexPath.row] as? Service,
           service.id != -1 {
            showService(service)
        }
    }
}

// MARK: - Services View Model Methods
extension ServicesVC: ServicesDelegate {
    func fetched(_ error: Error?) {
        SVProgressHUD.dismiss()
        if let error = error {
            print(error.localizedDescription)
            print(error.localizedDescription)
            guard let failedView = UIStoryboard(name: Storyboards.FailedRequestView, bundle: nil)
                .instantiateViewController(withIdentifier: FailedRequestVC.strId) as? FailedRequestVC else { return }
            failedView.modalPresentationStyle = .overCurrentContext
            failedView.delegate = self
            present(failedView, animated: false)
        } else {
            collectionView!.reloadData()
        }
    }
}

// MARK: - Horizontal Item Methods
extension ServicesVC: HorizontalListDelegate {
    func popularService(post: Service, heroId: String) {
        showService(post, heroId)
    }
    
    func blogPost(with link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            /// I see that the reader mode can be used with Armut Blog.
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            /// I will use form sheet comes from bottom over the page.
            vc.modalPresentationStyle = .formSheet
            present(vc, animated: true)
        }
    }
}

// MARK: - Failed Requests View Methods
extension ServicesVC: FailedRequestsDelegate {
    func retry() {
        servicesVM.fetch()
    }
}
