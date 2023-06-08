//
//  UIImageViewCacheExtension.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import SwiftUI

extension UIImageView {
    func loadImage(from url: URL, imageCache: ImageCache) {
        if let cachedImage = imageCache.getCachedImage(forURL: url.absoluteString) {
            self.image = cachedImage
            print("Image loaded from cache.")
            return
        } //: let cachedImage
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                print("Failed to download image.")
                return
            } //: guard
            
            DispatchQueue.main.async {
                self.image = image
                imageCache.cacheImage(image, forURL: url.absoluteString)
//                print("Image downloaded and cached successfully.")
            } //: DispatchQueue.main.async
        }.resume()
    } //: loadImage
} //: UIImageView
