//
//  ContentView.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @StateObject private var recipeViewModel = RecipeViewModel()
//    @StateObject private var recipeViewModel: RecipeViewModel
    
    @State var isActive: Bool = false
    
//    init(networkManager: NetworkManager) {
//        _recipeViewModel = StateObject(wrappedValue: RecipeViewModel(networkManager: networkManager))
//    }
    
    // MARK: - BODY
    var body: some View {
        
        
        if self.isActive == false {
            VStack {

                Spacer()
                VStack {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .frame(maxWidth: 150, maxHeight: 150)
                    Text("Dessert Cookbook")
                        .font(.largeTitle)
                        .fontDesign(.serif)

                }
                Spacer()

            } //: VSTACK
            .padding()
            .onAppear {
                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                } //: DispatchQueue
            } //: .ONAPPEAR

        } else {
            
            // MARK: - RECIPE LIST
            
            NavigationView {

                List(recipeViewModel.meals.sorted { $0.name < $1.name }) { recipe in
                    
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {

                        HStack(spacing: 15) {
                            
                            ImageView(urlString: recipe.image ?? "")
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(15)
                                .padding(5)
                            
                            Text(recipe.name) //: Meal Name
                                .padding(.leading, 5)
                                .padding(.trailing, 15)
                                .font(.title3)
                                .fontDesign(.serif)

                        } //: HStack

                    } //: NavigationLink

                } //: List
                .navigationTitle("Dessert Cookbook")
                
            } //: NavigationView
            .onAppear {
                
                recipeViewModel.fetchRecipes()
                print("Ran: fetchRecipes() called.")
            } //: onAppear
            
        } //: isActive status
        
        
    } //: body
}
