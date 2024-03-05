//
//  IPSE_Assignment_1App.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 21/8/2023.
//

import SwiftUI

@main
/// The main entry point for the IPSE Assignment 1 application.
///This `App` struct initializes the core objects and establishes the environment for the application. It manages the application's scenes and their associated views.
///The application consists of the following state objects:
///`Session`: Manages user authentication and session data.
///`CalorieManager`: Manages calorie tracking and related data.
///`DataController`: Provides a managed object context for Core Data operations.

struct IPSE_Assignment_1App: App {
    
    @StateObject var session = Session()
    @StateObject private var calorieTracker = CalorieManager()
    @StateObject private var dataController = DataController()
    @StateObject var userDefaults = UserDefaultsClass()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
                .environmentObject(calorieTracker)
                .environmentObject(userDefaults)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        
        }
    }
}
