//
//  Meal.swift
//  IPSE-Assignment_1
//
//  Created by apple on 10/10/23.
//

import Foundation

/// Struct to store search results received from REST API calls.
struct SearchResults: Codable {
    let results: [Meal]
    let offset: Int
    let number: Int
    let totalResults: Int
}

/// Struct to create a Meal object for each search result.
struct Meal: Identifiable, Codable {
    var id: Int
    var title: String
    var image: URL
    var imageType: String
}


