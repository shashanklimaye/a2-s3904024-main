//
//  MealLoggingView.swift
//  iPSE-Assignment-1
//
//  Created by Ashwin on 25/08/23.
//

import SwiftUI

/// User can log meals throigh this screen. User can set calories, meal of the day and mood for each meal.
struct MealLoggingView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var session : Session
    
    @State  var selectedMeal: String = "Breakfast"
    @State  var mood: String = "Good"
    @State var calorieCount : Double = 0
    @State  var showMoodInput: Bool = false
    @State  var showHomePage: Bool = false
    @State  var isLoading: Bool = false // Loading state variable

    let foodItemName : String

    var body: some View {
        NavigationStack {
            if showHomePage {
                HomePageView()
            } else if isLoading { // Check for loading state
                ActivityIndicator()
            } else {
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                        }
                        .padding(30)
                        .background(Color.green)
                        Text("New Meal")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    Form {
                        Section(header: Text("Meal Type")) {
                            Picker("Meal", selection: $selectedMeal) {
                                Text("Breakfast").tag("Breakfast")
                                Text("Lunch").tag("Lunch")
                                Text("Dinner").tag("Dinner")
                                Text("Snack").tag("Snack")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Food Item")) {
                            Text("\(foodItemName)")
                        }
                        
                        Section(header: Text("Calories")) {
                            Text("Enter Calories: \(Int(calorieCount))")
                                .foregroundColor(.gray)
                            Slider(value: $calorieCount, in: 0...1000, step: 10)
                        }
                        
                        Section(header: Text("Mood After Meal")) {
                            Picker("Mood", selection: $mood) {
                                Text("Great").tag("Great")
                                Text("Good").tag("Good")
                                Text("Bad").tag("Bad")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Button(action: {
                            
                            DataController().addRecord(context: managedObjectContext, foodname: foodItemName, calories: Float(calorieCount), mood: mood, mealtype: selectedMeal, userId: session.userProfile.userId)
                                showMoodInput = true
                            dismiss()
                        }) {
                            Text("Log Meal")
                                .padding(.all)
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .alert(isPresented: $showMoodInput) {
                        Alert(title: Text("Meal Logged"), message: Text("Your meal and mood have been logged successfully!"), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}




