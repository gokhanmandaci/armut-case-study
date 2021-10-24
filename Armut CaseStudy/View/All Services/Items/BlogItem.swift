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
    private let gradientView = GradientView()
    
    // MARK: - Outlets
    @IBOutlet weak var imgBlog: DownloaderImageView!
    @IBOutlet weak var lblBlogCategory: UILabel!
    @IBOutlet weak var lblBlogTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgBlog.addSubview(gradientView)
        gradientView.frame = imgBlog.frame
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
