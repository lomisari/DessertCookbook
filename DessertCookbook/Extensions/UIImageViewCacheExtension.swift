//
//  UIImageViewCacheExtension.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import SwiftUI


extension UIImageView {
    func loadImage(from url: URL) {
        if let cachedImage = ImageCache.shared.getCachedImage(forURL: url.absoluteString) {
            self.image = cachedImage
            return
        } //: let cachedImage
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
                // MARK: - Cache the image
                ImageCache.shared.cacheImage(image, forURL: url.absoluteString)
            }
        }.resume()
        
    } //: loadImage
} //: UIImageView
