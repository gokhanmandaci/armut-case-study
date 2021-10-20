//
//  PopularCellView.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit

class PopularCell: UICollectionViewCell {
    // MARK: - Parameters
    static let reuseId = "popularCellViewReuseId"
    private var populars = [Service]()
    
    // MARK: - Outlets
    @IBOutlet weak var clvPopulars: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clvPopulars.delegate = self
        clvPopulars.dataSource = self
        
        let popularItem = UINib(nibName: Nibs.PopularItemView, bundle: nil)
        clvPopulars.register(popularItem,
                             forCellWithReuseIdentifier: PopularItem.reuseId)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 140)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        clvPopulars.collectionViewLayout = layout
    }
}

// MARK: - Methods
extension PopularCell {
    func setCell(_ list: [Service]) {
        if populars.isEmpty {
            populars.append(contentsOf: list)
            clvPopulars.reloadData()
        }
    }
}

// MARK: - UICollectionView Methods
extension PopularCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        populars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PopularItem.reuseId,
            for: indexPath) as? PopularItem else { return UICollectionViewCell() }
        
        let service = populars[indexPath.row]
        cell.setCell(service)
        
        return cell
    }
}
