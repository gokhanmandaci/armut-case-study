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
    private let reuseIdentifier = "servicesCell"
    private let servicesVM = ServicesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(UICollectionViewCell.self,
                                 forCellWithReuseIdentifier: reuseIdentifier)
        
        let nibHeader: UINib = UINib(nibName: Nibs.ServicesHeader, bundle: nil)
        collectionView!.register(nibHeader,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ServicesHeader.reuseId)
        
        servicesVM.delegate = self
        SVProgressHUD.show()
        servicesVM.fetch()
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
            return values.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: ServicesHeader.reuseId,
                                                                             for: indexPath)
            return headerView
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
        }
        return .zero
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
