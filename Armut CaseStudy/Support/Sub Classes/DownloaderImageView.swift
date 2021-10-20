//
//  DownloaderImageView.swift
//  Armut CaseStudy
//
//  Created by Gökhan Mandacı on 20.10.2021.
//

import Foundation
import Kingfisher
import SVGKit

public struct SVGImgProcessor: ImageProcessor {
    public var identifier: String = "com.gokhanmandaci.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}

class DownloaderImageView: UIImageView {
    func dlImage(urlString: String,
                   placeholder: UIImage? = nil,
                   color: UIColor? = nil) {
        
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        
        if let url = URL(string: urlString) {
            self.kf.indicatorType = .activity
            if color != nil,
               let indicator = self.kf.indicator,
               let view = indicator.view as? UIActivityIndicatorView {
                view.color = color!
            }
            
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
            self.image = placeholder
        }
    }
    
    func dlSVGImage(urlString: String) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url,
                             options: [.processor(SVGImgProcessor())])
        }
    }
    
    func setSVGImage(_ image: UIImage) {
        
    }
}
