//
//  ImageView.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import Foundation
import SwiftUI

struct ImageView: View {
    // MARK: - PROPERTIES
    @StateObject private var imageLoader: ImageLoader
    
    init(urlString: String) {
//        let cacheDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("ImageCache")
        let imageCache = ImageCache.shared
                
        let loader = ImageLoader(urlString: urlString, imageCache: imageCache)
        self._imageLoader = StateObject(wrappedValue: loader)
    } //: init
    
    // MARK: - BODY
    var body: some View {
        
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "fork.knife")
        } //: if else
        
    } //: body
} //: ImageView

