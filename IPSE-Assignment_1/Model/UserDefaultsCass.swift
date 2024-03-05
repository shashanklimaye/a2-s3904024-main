//
//  UserDefaultsCass.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 14/10/2023.
//

import Foundation

/// Handling UserDefault Values in this class
class UserDefaultsClass : ObservableObject{
    
    /// Sets diet suggestions tracking flag
    /// - Parameter isDietSuggestionsEnabled: boolean value to set the flag .
    func setDietSuggestionsEnabled(isDietSuggestionsEnabled : Bool){
        UserDefaults.standard.set(isDietSuggestionsEnabled, forKey: "isDietSuggestionsEnabled");
    }
    /// Sets calorie tracking flag
    /// - Parameter isTrackCaloriesEnabled:  boolean value to set the flag .
    func setTrackCaloriesEnabled(isTrackCaloriesEnabled : Bool){
        UserDefaults.standard.set(isTrackCaloriesEnabled, forKey: "isTrackCaloriesEnabled");
    }
    
   
    
}
