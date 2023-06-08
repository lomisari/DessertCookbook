//
//  RecipeDetailView.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/25/23.
//

import SwiftUI

struct RecipeDetailView: View {
    // MARK: - PROPERTIES
    let recipe: Recipe
    
    // MARK: - BODY
    var body: some View {
        
        // MARK: - RECIPE DETAILS
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                // MARK: - Meal Header Image
                ImageView(urlString: recipe.image ?? "")
                    .scaledToFill()
                    .cornerRadius(15)

                // MARK: - Recipe Details - Meal name, Instructions, and Ingredients
                VStack(alignment: .leading, spacing: 10) {
                    
                    // MARK: - Meal Name
                    Text(recipe.name)
                        .font(.title)
                        .fontDesign(.serif)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(alignment: .leading)
                        .cornerRadius(15)

                    // MARK: - Instructions and Ingredients
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Instructions")
                            .font(.title3)
                            .fontDesign(.serif)
                            .bold()
//                            .padding(.vertical)

                        Text(recipe.instructions ?? "") //: Recipe Instructions
                            .font(.body)
                            .fontDesign(.serif)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        
                        Text("Ingredients")
                            .font(.title3)
                            .fontDesign(.serif)
                            .bold()
                        
                        // MARK: - Recipe Ingredients List
                        generateIngredientsList()
                        
                    } //: VStack
                    
                } //: VStack
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                
            }  //: VStack
            .padding(.horizontal)
            .navigationBarTitle("Dessert")
            .navigationBarTitleDisplayMode(.inline)

        } //: ScrollView
        
        
    } //: Body
    
    @ViewBuilder private func generateIngredientsList() -> some View {
        let zippedArray = Array(zip(recipe.measurements, recipe.ingredients))
        let filteredArray = zippedArray.filter { !$0.0.isEmpty && !$0.1.isEmpty }
        
        ForEach(filteredArray, id: \.0) { (measurement, ingredient) in
            Text("• \(measurement) \(ingredient)")
                .id(UUID())
                .font(.body)
                .fontDesign(.serif)
        }
    } //: ViewBuilder

    
} //: RecipeDetailView
