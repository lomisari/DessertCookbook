//
//  ImageCache.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import Foundation
import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func cacheImage(_ image: UIImage, forURL urlString: String) {
        cache.setObject(image, forKey: urlString as NSString)
    } //: cacheImage
    
    func getCachedImage(forURL urlString: String) -> UIImage? {
        return cache.object(forKey: urlString as NSString)
    } //: getCachedImage
    
} //: ImageCache
