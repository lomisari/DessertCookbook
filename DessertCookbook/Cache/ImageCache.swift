//
//  ImageCache.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import Foundation
import UIKit

class ImageCache {
    
    static let shared = ImageCache(maxSize: 500 * 1024 * 1024, cacheDirectory: FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!) //: Singleton instance to ensure ImageCache persists throughout the lifetime of the app
    
    let cacheDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("ImageCache")

    private let cache = NSCache<AnyObject, AnyObject>()
    private let maxSize: Int //: Maximum size of the cache in bytes
    private let cacheDirectory: URL //: Directory to store cached images

    
    init(maxSize: Int, cacheDirectory: URL) {
        self.maxSize = maxSize
        self.cacheDirectory = cacheDirectory
        cache.totalCostLimit = maxSize
    } //: init

    func cacheImage(_ image: UIImage, forURL urlString: String) {
        cache.setObject(image, forKey: urlString as NSString, cost: image.diskSize)
        
        if cache.totalCostLimit >= maxSize {
            //: If cache exceeds the maximum size, remove least recently used objects until it fits
            let removalCount = (cache.totalCostLimit - maxSize) / MemoryLayout<UIImage>.size
            
            for _ in 0..<removalCount {
                if let keyToRemove = cache.delegate?.cache?(cache, willEvictObject: cache) as? NSString {
                    cache.removeObject(forKey: keyToRemove)
                } else {
                    break
                } //: if
            } //: for in
        } //: if
//        print("Image cached for URL: \(urlString)")
    } //: func
    
    func getCachedImage(forURL urlString: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: urlString as AnyObject) as? UIImage {
//            print("Image loaded from cache for URL: \(urlString)")
            return cachedImage
        }
//        print("Image not found in cache for URL: \(urlString)")
        return nil
    } //: func
    
} //: ImageCache

//:
extension UIImage {
    var diskSize: Int {
        guard let cgImage = cgImage else { return 0 }
        return cgImage.bytesPerRow * cgImage.height
    } //: var
} //: ext
