//
//  DownloaderImageView.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation
import Kingfisher

class DownloaderImageView: UIImageView {
    func dlImage(urlString: String?,
                   placeholder: UIImage? = nil) {
        
        guard let urlStr = urlString else {
            image = nil
            return
        }
        
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        
        if let url = URL(string: urlStr) {
            self.kf.indicatorType = .activity
            
            self.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.none),
                    .processor(processor),
                    .cacheOriginalImage
                ], progressBlock: nil) { (result) in
                switch result {
                case .success(_):
//                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    break
                case .failure(_):
//                    print("Job failed: \(error.localizedDescription)")
                    break
                }
            }
        } else {
            image = placeholder
        }
    }
}
