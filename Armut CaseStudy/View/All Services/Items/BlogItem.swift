//
//  BlogItem.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import UIKit

class BlogItem: UICollectionViewCell {
    // MARK: - Parameters
    static let reuseId = "blogItemViewReuseId"
    
    // MARK: - Outlets
    @IBOutlet weak var imgBlog: DownloaderImageView!
    @IBOutlet weak var lblBlogCategory: UILabel!
    @IBOutlet weak var lblBlogTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.shouldRasterize = true
        imgBlog.layer.addSublayer(gradientLayer)
    }
}

// MARK: - Methods
extension BlogItem {
    func setCell(_ blog: Post) {
        imgBlog.dlImage(urlString: blog.imageURL)
        lblBlogCategory.text = blog.category
        lblBlogTitle.text = blog.title
    }
}
