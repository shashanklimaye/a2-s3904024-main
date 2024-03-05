//
//  CalorieTracker.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 15/10/2023.
//

import Foundation
import SwiftUI

/// This class manages calorie count for the user.
class CalorieManager: ObservableObject {
    @Published var globalCalorieCount: Int = 0

    
    /// Method to set the calorie goal for the day.
    /// - Parameter value: Integer value to set calorie goal.
    func setCalorieCount(_ value: Int) {
        globalCalorieCount = value
        UserDefaults.standard.set(value, forKey: "TargetCalories")
    }
}
