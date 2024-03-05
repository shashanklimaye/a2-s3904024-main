
//
//  Created by Shashank Limaye on 11/10/2023.
//

import SwiftUI

/// User set calorie target will appear on this view.
/// User's daily calorie cout will also be tracked on this view.
struct CalorieTrackingView: View {
    
    @FetchRequest(sortDescriptors:[],predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [NSPredicate(format: "date >= %@", Calendar.current.startOfDay(for: Date()) as NSDate), NSPredicate(format: "userId == %@", UserDefaults.standard.string(forKey: "UserId") ?? "")])) var todayMeals : FetchedResults<Record>
    
    
    var totalCalories: Int {
        todayMeals.reduce(0) { $0 + Int($1.calories) }
        }
    
    @EnvironmentObject var calorieTracker: CalorieManager
    

    var body: some View {
        if UserDefaults.standard.bool(forKey: "isTrackCaloriesEnabled"){
            VStack{
                Spacer()
                Text("My Goal")
                    .bold()
                    .font(.system(size: 45))
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.8).gradient)
                        .frame(maxWidth: .infinity)
                        .frame(height: 110)
                    if UserDefaults.standard.object(forKey: "TargetCalories") != nil{
                        let calorieTarget = UserDefaults.standard.integer(forKey: "TargetCalories")
                        Text("\(calorieTarget) kcal")
                            .bold()
                            .font(.system(size: 35))
                    }
                    else{
                        Text("\(calorieTracker.globalCalorieCount) kcal")
                            .bold()
                            .font(.system(size: 35))
                    }
                    
                }
                
                Text("Today")
                    .bold()
                    .font(.system(size: 45))
                if UserDefaults.standard.object(forKey: "TargetCalories") != nil{
                    let calorieTarget = UserDefaults.standard.integer(forKey: "TargetCalories")
                    if totalCalories > calorieTarget {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.red.opacity(0.50))
                                .frame(maxWidth: .infinity)
                                .frame(height: 110)
                            Text("\(totalCalories) kcal")
                                .bold()
                                .font(.system(size: 35))
                        }
                    }
                    else if totalCalories == calorieTarget{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.green.opacity(0.50))
                                .frame(maxWidth: .infinity)
                                .frame(height: 110)
                            Text("\(totalCalories) kcal")
                                .bold()
                                .font(.system(size: 35))
                        }
                    }
                    else{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.yellow.opacity(0.50))
                                .frame(maxWidth: .infinity)
                                .frame(height: 110)
                            Text("\(totalCalories) kcal")
                                .bold()
                                .font(.system(size: 35))
                        }
                    }
                    
                }
                else{
                    if totalCalories > calorieTracker.globalCalorieCount {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.yellow.opacity(0.5).gradient)
                                .frame(maxWidth: .infinity)
                                .frame(height: 110)
                            Text("\(totalCalories) kcal")
                                .bold()
                                .font(.system(size: 35))
                        }
                    }
                    else if totalCalories == calorieTracker.globalCalorieCount{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.yellow.opacity(0.5).gradient)
                                .frame(maxWidth: .infinity)
                                .frame(height: 110)
                            Text("\(totalCalories) kcal")
                                .bold()
                                .font(.system(size: 35))
                        }
                    }
                    else{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.yellow.opacity(0.5).gradient)
                                .frame(maxWidth: .infinity)
                                .frame(height: 110)
                            Text("\(totalCalories) kcal")
                                .bold()
                                .font(.system(size: 35))
                        }
                    }
                }
                
                
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.4).gradient)
        }
        else{
            VStack{
                Spacer()
                Text("My Goal")
                    .bold()
                    .font(.system(size: 45))
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.8).gradient)
                        .frame(maxWidth: .infinity)
                        .frame(height: 110)
                    Text("Tracking Not Enabled")
                        .bold()
                        .font(.system(size: 35))
                }
                
                Text("Today")
                    .bold()
                    .font(.system(size: 45))
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.red.opacity(0.50))
                        .frame(maxWidth: .infinity)
                        .frame(height: 110)
                    Text("Tracking Not Enabled")
                        .bold()
                        .font(.system(size: 35))
                }
                
                
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.4).gradient)
        }
        
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
     CalorieTrackingView()
    }
}
