//
//  MealLoggingViewTests.swift
//  IPSE-Assignment_1Tests
//
//  Created by apple on 15/10/23.
//

import XCTest
@testable import IPSE_Assignment_1
import SwiftUI

class MealLoggingViewTests: XCTestCase {
    
    func testMealLoggingView() {
        // Create an instance of MealLoggingView
        let mealLoggingView = MealLoggingView(foodItemName: "Apple")
        
        // 1. Initial UI Setup
        XCTAssertEqual(mealLoggingView.selectedMeal, "Breakfast")
        XCTAssertEqual(mealLoggingView.mood, "Good")
        XCTAssertEqual(mealLoggingView.calorieCount, 0)
        XCTAssertFalse(mealLoggingView.showMoodInput)
        XCTAssertFalse(mealLoggingView.showHomePage)
        XCTAssertFalse(mealLoggingView.isLoading)
        
        // 2. User Interactions
        mealLoggingView.selectedMeal = "Breakfast"
        XCTAssertEqual(mealLoggingView.selectedMeal, "Breakfast")
        
        mealLoggingView.mood = "Good"
        XCTAssertEqual(mealLoggingView.mood, "Good")
        
       mealLoggingView.calorieCount = 0
        XCTAssertEqual(mealLoggingView.calorieCount, 0)
        
        
        
    }
    
       func testChangingValuesOfUIElements() {
           let mealLoggingView = MealLoggingView(foodItemName: "Apple")

           // Changing Values
           mealLoggingView.selectedMeal = "Dinner"
           mealLoggingView.mood = "Bad"
           mealLoggingView.calorieCount = 500.0
       
           // Assert
           XCTAssertEqual(mealLoggingView.selectedMeal, "Breakfast")
           XCTAssertEqual(mealLoggingView.mood, "Good")
           XCTAssertEqual(mealLoggingView.calorieCount, 0)
       }
    
}

