//
//  ImageView+.swift
//  altar
//
//  Created by Tri on 8/8/20.
//

import SDWebImage

extension UIImageView {
    func imageAnimation(_ imageName: String, _ duration: Double) {
        var images: [UIImage] = []
        while let image = UIImage(named: String(format: "%@_%010d", imageName, images.count)) {
            images.append(image)
        }
        animationImages = images
        animationDuration = duration
        startAnimating()
    }
    
    func loadImage(with imageURL: String?, placeHolder: UIImage? = nil) {
        image = placeHolder
        guard let imageURL = imageURL else { return }
        guard let url = URL(string: imageURL) else { return }
        sd_imageTransition = .fade
        sd_setImage(with: url, placeholderImage: placeHolder)
    }
}
