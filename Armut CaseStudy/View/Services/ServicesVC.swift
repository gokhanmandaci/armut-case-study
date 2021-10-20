//
//  ServicesVC.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit
import SVProgressHUD

class ServicesVC: UICollectionViewController {
    // MARK: - Parameters
    private let servicesVM = ServicesVM()
    private let layout = UICollectionViewFlowLayout()
    
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
}

// MARK: - Methods
extension ServicesVC {
    /// Setup page layout, registrations of UI elements
    private func setup() {
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
        let popularServiceItem = UINib(nibName: Nibs.PopularCellView, bundle: nil)
        collectionView!.register(popularServiceItem,
                                 forCellWithReuseIdentifier: PopularCell.reuseId)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
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
        if let serviceItems = servicesVM.services[indexPath.section].values.first,
           let serviceItem = serviceItems[indexPath.row] as? Service {
            /// First all services and then populars
            if indexPath.section == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllServicesItem.reuseId,
                                                                    for: indexPath) as? AllServicesItem else { return UICollectionViewCell() }
                cell.setCell(serviceItem)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseId,
                                                                    for: indexPath) as? PopularCell else { return UICollectionViewCell() }
                
                if let popularServices = serviceItems as? [Service] {
                    cell.setCell(popularServices)
                }
                return cell
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            // Calculate width dynamically
            let dimen = (Helper.getWidth() - ((3 * 10) + (2 * 20))) / 4
            return CGSize(width: dimen, height: dimen)
        } else {
            return CGSize(width: Helper.getWidth(), height: 140)
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
                    if indexPath.section == 1 {
                        header.lblTitle.font = UIFont.boldSystemFont(ofSize: 14)
                    } else {
                        header.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
                    }
                    header.lblTitle.text = servicesVM.services[indexPath.section].keys.first ?? ""
                    return header
                }
            }
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionView Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // This will be our header view
        if section == 0 {
            /// Header index path
            let indexPath = IndexPath(row: 0, section: section)
            /// We get the header item.
            let servicesHeader = self.collectionView(collectionView,
                                                      viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                                      at: indexPath)
            
            // Here with systemLayoutSizeFitting our header size will be dynamic
            // because we used auto-layout and bind the boundaries.
            return servicesHeader.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                                 height: UIView.layoutFittingExpandedSize.height
                                                                ),
                                                          withHorizontalFittingPriority: .required,
                                                          verticalFittingPriority: .fittingSizeLevel)
        } else if section == 1 {
            return CGSize(width: Helper.getWidth(), height: 50)
        } else {
            return CGSize(width: Helper.getWidth(), height: 90)
        }
    }
}

// MARK: - Services View Model Methods
extension ServicesVC: ServicesDelegate {
    func fetched(_ error: Error?) {
        SVProgressHUD.dismiss()
        if let error = error {
            print(error.localizedDescription)
        } else {
            collectionView!.reloadData()
        }
    }
}
