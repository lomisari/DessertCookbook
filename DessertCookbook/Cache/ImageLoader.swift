//
//  ImageLoader.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let urlString: String
    private let imageCache: ImageCache
    
    init(urlString: String, imageCache: ImageCache) {
        self.urlString = urlString
        self.imageCache = imageCache
        loadImage()
    } //: init
    
    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = imageCache.getCachedImage(forURL: urlString) {
            print("Image loaded from cache.")
            self.image = cachedImage
            return
        } //: if
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            } //: if
            
            guard let data = data, let loadedImage = UIImage(data: data) else {
                print("Failed to load image data from URL: \(self.urlString)")
                return
            } //: guard
            
            
            DispatchQueue.main.async {
                self.image = loadedImage
                ImageCache.shared.cacheImage(loadedImage, forURL: self.urlString)
                print("Image downloaded and cached successfully from URL: \(self.urlString)")
            } //: DispatchQueue.main.async
        }.resume()
        
    } //: loadImage()
    
} //: class

