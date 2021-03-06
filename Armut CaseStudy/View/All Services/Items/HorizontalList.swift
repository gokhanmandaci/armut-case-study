//
//  HorizontalList.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit
import SafariServices
import Hero

protocol HorizontalListDelegate {
    func blogPost(with link: String)
    func popularService(post: Service, heroId: String)
}

class HorizontalList: UICollectionViewCell {
    // MARK: - Parameters
    static let reuseId = "horizontalListViewReuseId"
    var populars: [Service]?
    var posts: [Post]?
    var delegate: HorizontalListDelegate?
    
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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        clvList.collectionViewLayout = layout
        
        contentView.backgroundColor = .clear
        
    }
}

// MARK: - Methods
extension HorizontalList {
    func setCell(for populars: [Service]) {
        if self.populars == nil {
            self.populars = populars
            clvList.reloadData()
        }
    }
    
    func setCell(for posts: [Post]) {
        if self.posts == nil {
            self.posts = posts
            clvList.reloadData()
        }
    }
}

// MARK: - UICollectionView Methods
extension HorizontalList: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            cell.imgService.hero.id = "popular\(indexPath.row)"
            cell.setCell(service)
            
            return cell
        } else if let posts = self.posts {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BlogItem.reuseId,
                for: indexPath) as? BlogItem else { return UICollectionViewCell() }
            
            let blog = posts[indexPath.row]
            cell.accessibilityIdentifier = "popular\(indexPath.row)"
            cell.setCell(blog)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Let's check the types and decide the action
        if let cell = collectionView.cellForItem(at: indexPath) {
            // Did select method
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = .systemGray
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    cell.transform = .identity
                    cell.contentView.backgroundColor = .clear
                } completion: { [self] _ in
                    if let populars = self.populars {
                        let popularService = populars[indexPath.row]
                        delegate?.popularService(post: popularService,
                                                 heroId: "popular\(indexPath.row)")
                    } else if let posts = self.posts {
                        let post = posts[indexPath.row]
                        delegate?.blogPost(with: post.link)
                    }
                }
            }
        }
    }
    
    // MARK: - UICollectionView Delegate Methods
    // Let's add some animations to make UI interactive
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.1) {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = .systemGray
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            // After selection, cell will return identity
            // After drag out this code should work only
            // Checking background color for that purpose
            if cell.contentView.backgroundColor != .clear {
                UIView.animate(withDuration: 0.1) {
                    cell.transform = .identity
                    cell.contentView.backgroundColor = .clear
                }
            }
        }
    }
    
    // MARK: - UICollectionView Delegate Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.populars != nil {
            var width: CGFloat = 150
            var height: CGFloat = 140
            if UIDevice.current.userInterfaceIdiom == .pad {
                width = 200
                height = 190
            }
            return CGSize(width: width, height: height)
        } else {
            var width: CGFloat = 150
            var height: CGFloat = 200
            if UIDevice.current.userInterfaceIdiom == .pad {
                width = 200
                height = 250
            }
            return CGSize(width: width, height: height)
        }
    }
}
