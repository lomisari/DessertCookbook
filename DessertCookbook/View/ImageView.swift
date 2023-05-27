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
        _imageLoader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
    }
    
    // MARK: - BODY
    var body: some View {
        
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "fork.knife")
        }
        
    } //: body
} //: ImageView

