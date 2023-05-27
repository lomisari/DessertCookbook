//
//  Recipe.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/25/23.
//

import Foundation

struct Recipe: Codable, Identifiable {
    
    // MARK: - Convert idMeal -> id to ensure Recipe conforms to the 'Identifiable' protocol
    var id: String {
        return customID ?? idMeal
    }
    let idMeal: String
    var customID: String? //: New property to store the updated URL string
    
    
    // MARK: - Meal Details
    var strMeal: String //: Meal Name
    var strMealThumb: String?
    var strInstructions: String?
    
    //: Ingrdients
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?

    //: Measurements
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?

    // MARK: - Ingredients Array
    var ingredients: [String] {
        let allIngredients = [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ]
        
        // MARK: - Filter out nil values and return the result
        return allIngredients.compactMap { $0 }
    }

    // MARK: - Measurements Array
    var measurements: [String] {
        let allMeasurements = [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
            strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        ]
        
        // MARK: - Filter out nil values and return the result
        return allMeasurements.compactMap { $0 }
    }
    
    // MARK: - Ingredients And Measurements Array    
    
    var ingredientsAndMeasurements: [String] {

        var combinedArray: [String] = []

        for (index, ingredient) in ingredients.enumerated() {
            if index < measurements.count {
                let measurement = measurements[index]
                let ingAndMeasCombinedString = "\(ingredient): \(measurement)"
                combinedArray.append(ingAndMeasCombinedString)
            } else {
                combinedArray.append(ingredient)
            } //: If Else
        }

        return combinedArray

    }
}

struct MealsResponse: Codable {
    var meals: [Recipe]
}
