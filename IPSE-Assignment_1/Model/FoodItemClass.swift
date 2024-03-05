//
//  FoodItemClass.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 12/10/2023.
//

import Foundation


/// Class to handle query response from REST API.
class FoodItemsViewModel: ObservableObject {
    @Published var foodItems: [Meal] = []
    
    /// fetchFoodItems is a method used to fetch the food items from REST API.
    /// - Parameter query: a String value as a search query.
    func fetchFoodItems(query: String) {
        APIService.shared.searchFood(query: query) { result in
            switch result {
            case .success(let searchResults):
                DispatchQueue.main.async {
                    self.foodItems = searchResults.results.map { Meal(id: $0.id, title: $0.title, image: $0.image, imageType: $0.imageType) }
                }
            case .failure(let error):
                print("Error fetching food items: \(error)")
            }
        }
    }
    
    /// filteredFoodItems is a method which filters the array of fetched results from REST API.
    /// - Parameter searchText: String parameter used to filter the array.
    /// - Returns: Returns an list of objects of Class Meal depending on the filter string.
    func filteredFoodItems(_ searchText: String) -> [Meal] {
        if searchText.isEmpty {
            return foodItems
        } else {
            return foodItems.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}

