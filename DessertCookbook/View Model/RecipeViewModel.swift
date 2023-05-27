//
//  RecipeViewModel.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/25/23.
//

import Foundation

class RecipeViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var meals: [Recipe] = []
    
    private let networkManager = NetworkManager()
    
    func fetchRecipes() {
        
        networkManager.fetchMeals { result in
            
            switch result {
                
            case .success((let mealsResponse, _)):
                DispatchQueue.main.async {
                    // MARK: - MealsResponse meals data fetched from successful run of decoder in NetworkManager()
                    self.meals = mealsResponse.meals
                } //: DispatchQueue.main.async
                
            case .failure(let error):
                print("Error fetching meals data: \(error)")
                                
            } //: switch
            
        } //: networkManager.fetchMeals
    } //: fetchRecipes
    
    
}
