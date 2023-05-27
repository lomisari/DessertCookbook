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
    
    init(urlString: String) {
        self.urlString = urlString
        loadImage()
    }
    
    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let loadedImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = loadedImage
                ImageCache.shared.cacheImage(loadedImage, forURL: self.urlString)
            } //: DispatchQueue.main.async
            
        }.resume()
        
    } //: loadImage()
    
}

