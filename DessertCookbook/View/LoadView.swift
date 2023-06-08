//
//  LoadView.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import SwiftUI

struct LoadView: View {
    // MARK: - PROPERTIES
    @State var isActive: Bool = false
    
    // MARK: - BODY
    var body: some View {

        VStack {
            
            Text("Dessert Cookbook")
                .font(.largeTitle)
                .fontDesign(.serif)
            
        } //: VSTACK
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                withAnimation{
                    self.isActive = true
                }
            } //: DISPATCHQUEUE
        } //: .ONAPPEAR
        
    } //: body
} //: LoadView

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
