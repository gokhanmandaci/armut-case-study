//
//  HorizontalList.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit

class HorizontalList: UICollectionViewCell {
    // MARK: - Parameters
    static let reuseId = "horizontalListViewReuseId"
    var populars: [Service]?
    var posts: [Post]?
    private let layout = UICollectionViewFlowLayout()
    
    // MARK: - Outlets
    @IBOutlet weak var clvList: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clvList.delegate = self
        clvList.dataSource = self
        
        let popularItem = UINib(nibName: Nibs.PopularItemView, bundle: nil)
        clvList.register(popularItem,
                             forCellWithReuseIdentifier: PopularItem.reuseId)
        
        let blogItem = UINib(nibName: Nibs.BlogItemView, bundle: nil)
        clvList.register(blogItem,
                             forCellWithReuseIdentifier: BlogItem.reuseId)
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        
    }
}

// MARK: - Methods
extension HorizontalList {
    func setCell(for populars: [Service]) {
        if self.populars == nil {
            self.populars = populars
            layout.itemSize = CGSize(width: 150, height: 140)
            clvList.collectionViewLayout = layout
            clvList.reloadData()
        }
    }
    
    func setCell(for posts: [Post]) {
        if self.posts == nil {
            self.posts = posts
            layout.itemSize = CGSize(width: 150, height: 200)
            clvList.collectionViewLayout = layout
            clvList.reloadData()
        }
    }
}

// MARK: - UICollectionView Methods
extension HorizontalList: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let popularCount = populars?.count {
            return popularCount
        } else if let postCount = posts?.count {
            return postCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let populars = self.populars {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularItem.reuseId,
                for: indexPath) as? PopularItem else { return UICollectionViewCell() }
            
            let service = populars[indexPath.row]
            cell.setCell(service)
            
            return cell
        } else if let posts = self.posts {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BlogItem.reuseId,
                for: indexPath) as? BlogItem else { return UICollectionViewCell() }
            
            let blog = posts[indexPath.row]
            cell.setCell(blog)
            
            return cell
        }
        return UICollectionViewCell()
    }
}
