//
//  NetworkManager.swift
//  DessertCookbook
//
//  Created by Nika Magradze on 5/26/23.
//

import Foundation

class NetworkManager {
    // MARK: - PROPERTIES
    static let shared = NetworkManager()
    
    init() {}
    
    func fetchMeals(completion: @escaping (Result<(MealsResponse, [String]), Error>) -> Void) {
        // MARK: - URL
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            // MARK: - URL Completion Failure
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // MARK: - URLSession Get Data
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                // MARK: - Data Fetch Completion Failure
                completion(.failure(NetworkError.noData))
                return
            }

            // MARK: - Decode with JSONDecoder()
            do {
                let decoder = JSONDecoder()
                var mealsResponseData = try decoder.decode(MealsResponse.self, from: data)
                let mealIDs = mealsResponseData.meals.map { $0.idMeal }

                // MARK: - Fetch meal details for each meal ID
                var fetchCount = 0
                var updatedMeals: [Recipe] = []
                for mealID in mealIDs {
                    self?.fetchMealDetails(mealID: mealID) { result in
                        switch result {
                        case .success(let mealDetails):
                                                        
                            updatedMeals.append(contentsOf: mealDetails.meals)
                                                        
                            fetchCount += 1

                            // Check if all fetches are completed
                            if fetchCount == mealIDs.count {
                                mealsResponseData.meals = updatedMeals //: Assign the updated meals array to mealsResponseData
                                completion(.success((mealsResponseData, mealIDs)))
                            }
                            
                        case .failure(let error):
                            print("Error fetching meal details: \(error)")
                            completion(.failure(error))
                            
                        } //: switch
                    } //: fetchMealDetails(mealID: mealID)
                } //: for mealID in mealIDs
            } catch {
                // MARK: - Failure
                completion(.failure(error))
            } //: do catch
        } //: URLSession.shared.dataTask
        .resume()
    } //: fetchMeals
    
    func fetchMealDetails(mealID: String, completion: @escaping (Result<MealsResponse, Error>) -> Void) {

        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mealsResponse = try decoder.decode(MealsResponse.self, from: data)
                completion(.success(mealsResponse))
            } catch {
                completion(.failure(error))
            }
            
        }
        .resume()
        
    } //: fetchMealDetails
    
}

// MARK: - Network Related Errors - called in fetchMeals() func
enum NetworkError: Error {
    case invalidURL
    case noData
}
