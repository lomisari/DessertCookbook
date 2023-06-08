//
//  NetworkManager.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import Foundation

// MARK: - Protocol for NetworkManager
protocol NetworkManagerProtocol {
    func fetchMeals() async throws -> MealsResponse
    func fetchMealInfo(mealID: String) async throws -> MealsResponse
} //: protocol

class NetworkManager: NetworkManagerProtocol {
    // MARK: - PROPERTIES
    static let shared = NetworkManager()
    
    init() {}
        
    // MARK: - Fetch meals data from url
    func fetchMeals() async throws -> MealsResponse {
        // MARK: - URL
        let endpointURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: endpointURL) else {
            throw NetworkError.invalidURL
        }
        
        // MARK: - Decode with JSONDecoder()
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            
            let decoder = JSONDecoder()
            let mealResponseData = try decoder.decode(MealsResponse.self, from: data)
            let mealIDs = mealResponseData.meals.map { $0.id }
            
            // MARK: - Fetch meal details for each meal by ID
            var updatedMeals: [Recipe] = []
            for mealID in mealIDs {
                
                let mealDetails = try await self.fetchMealInfo(mealID: mealID)
                updatedMeals.append(contentsOf: mealDetails.meals)
                
            } //: for in
            
            // MARK: - Update the meals in the response data with the fetched meal details
//            mealResponseData.meals = updatedMeals
            let updatedResponse = MealsResponse(meals: updatedMeals)
            
            return updatedResponse
            
        } catch {
            throw NetworkError.invalidData
        } //: do catch
        
    } //: fetchMeals()
    
    func fetchMealInfo(mealID: String) async throws -> MealsResponse {
        // MARK: - URL
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            throw NetworkError.invalidURL
        } //: let url
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        // MARK: - Decode with JSONDecoder()
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MealsResponse.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    } //: fetchMealInfo

} //: class NetworkManager

// MARK: - Network Related Errors - called in fetchMeals() func
enum NetworkError: Error {
    case invalidURL
    case invalidData
    case noData
    case invalidResponse
} //: enum
