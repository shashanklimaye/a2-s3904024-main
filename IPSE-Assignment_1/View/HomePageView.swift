

//
//  SplashScreenView.swift
//  IPSE-Assignment_1
//
//  Created by Ashwin on 26/08/23.
//

import SwiftUI
import Foundation

/// Home page of the application.
/// User can view their meals and filter according to mood and type of meal.
/// Users can access the meal logging view, calorie tracking view and profile view from this view.
struct HomePageView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    @EnvironmentObject var session : Session
    
    @State var isCalendarPresented : Bool = false
    @State var selectedDate : Date = Date()
    
    var isDietEnabled : Bool = true

    
    @FetchRequest(sortDescriptors:[],
                  predicate: NSPredicate(format: "userId == %@", UserDefaults.standard.string(forKey: "UserId") ?? ""),
                  animation: .default) var Meals : FetchedResults<Record>
    
    // New state variables for filters
    @State private var mealTimeFilter: String = "All Meals"
    @State private var moodFilter: String = "All Moods"
    


    var body: some View {
        ScrollView {
            NavigationStack {
                HStack{
                    NavigationLink(destination: CalorieTrackingView()) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                    NavigationLink(destination: FoodSearchView()) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                    }
                }
                .padding(30)
                
                HStack{
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 35))
                            .foregroundColor(.green)
                    }
                    Text("\(session.userProfile.name)")
                        .font(.title)
                    
                    Spacer()
                }
                .padding()
                
                // New filter pickers
                HStack {
                   
                    Picker("Meal Time", selection: $mealTimeFilter) {
                        Text("All Meals").tag("All Meals")
                        Text("Breakfast").tag("Breakfast")
                        Text("Lunch").tag("Lunch")
                        Text("Dinner").tag("Dinner")
                        Text("Snack").tag("Snack")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .disabled(!UserDefaults.standard.bool(forKey: "isDietSuggestionsEnabled"))
                   
                    Spacer()
                    Picker("Mood", selection: $moodFilter) {
                        Text("All Moods").tag("All Moods")
                        Text("Great").tag("Great")
                        Text("Good").tag("Good")
                        Text("Bad").tag("Bad")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
               
                
               
                
                // Using filtered meals
                ForEach(filteredMeals(), id: \.self) { meal in
                    foodItemView(meal: meal)
                }
                
                Spacer()
                
                .navigationBarBackButtonHidden(true)
                .popover(isPresented: $isCalendarPresented){
                    DatePicker("Select a date", selection: $selectedDate,
                               displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    Button("Done"){
                        isCalendarPresented.toggle()
                    }
                }
            }
        }
    }

    // New function to filter meals based on mealTimeFilter and moodFilter
    func filteredMeals() -> [Record] {
        return Meals.filter { meal in
            (mealTimeFilter == "All Meals" || meal.mealtype == mealTimeFilter) &&
            (moodFilter == "All Moods" || meal.mood == moodFilter)
        }
    }
}



struct foodItemView: View {
    
    let meal: Record
    
    var body: some View {
        ZStack {
            if meal.mood == "Bad"{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.red.opacity(0.20))
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
            }
            else if meal.mood == "Good"{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.yellow.opacity(0.20))
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
            }
            else{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.green.opacity(0.20))
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
            }
            
            VStack {
                HStack {
                    if meal.mood == "Great" {
                        Image(systemName: "face.smiling")
                            .font(.system(size: 25))
                    } else if meal.mood == "Bad" {
                        Image(systemName: "hand.thumbsdown.circle.fill")
                            .font(.system(size: 25))
                    } else if meal.mood == "Good" {
                        Image(systemName: "hand.thumbsup.circle.fill")
                            .font(.system(size: 25))
                    }
                    Spacer()
                    Text(meal.foodname ?? "")
                        .bold()
                }
                .padding()
                
                Spacer()
                VStack{
                    HStack {
                        Text("Calories: ")
                            .padding(.bottom, 15)
                        Text(String(meal.calories))
                            .bold()
                            .font(.system(size: 15))
                            .padding(.bottom, 15)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

