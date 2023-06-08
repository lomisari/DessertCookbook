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
    
    private let networkManager: NetworkManagerProtocol
        
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    } //: init
    
    func fetchRecipes() {
        Task {
            do {
                let mealResponse = try await networkManager.fetchMeals()
                DispatchQueue.main.async {
                    // MARK: - MealsResponse meals data fetched from decoder in NetworkManager()
                    self.meals = mealResponse.meals
                } //: DispatchQueue.main.async
            } catch {
                print("Error fetching meals data: \(error)")
            } //: catch
        } //: Task
    } //: fetchRecipes
} //: RecipeViewModel class
