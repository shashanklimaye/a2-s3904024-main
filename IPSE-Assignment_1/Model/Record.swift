import Foundation
import CoreData

/// DataController is a class which manages the interaction between the application and CoreData.
/// DataController manages food records data.
class DataController : ObservableObject{
    var container = NSPersistentContainer(name:"RecordModel")
    
    /// init function to initiate and load the container into the application.
    init(){
        container.loadPersistentStores{desc, error in
            if let error = error{
                print("Failed to load the data. \(error.localizedDescription)")
            }
        }
    }
    
    /// The save function saves changed state of the data locally, so it can be pushed to the database later on.
    /// - Parameter context: A managed object context is an instance of NSManagedObjectContext. Its primary responsibility is to manage a collection of managed objects.
    func save (context: NSManagedObjectContext) {
        do {
            try context.save ( )
            print ("Data saved")
        } catch {
            print ("We could not save the data. Please check your internet connection!")
        }
    }
    
    /// addRecord function adds food records to the CoreData.
    /// - Parameters:
    ///   - context: context is an instance of NSManagedObjectContext. Its primary responsibility is to manage a collection of managed objects.
    ///   - foodname: name of the food item being passed to CoreData
    ///   - calories: food item calorie count being passed to CoreData
    ///   - mood: mood while having the meal being passed to CoreData
    ///   - mealtype: Meal type (breakfast, lunch, dinner, snack) being passed to CoreData
    ///   - userId: id of the user who is creating the record being passed to CoreData
    func addRecord(context: NSManagedObjectContext, foodname: String, calories: Float, mood: String, mealtype: String, userId : String){
        
        let meal = Record(context:context)
        meal.id = UUID()
        meal.foodname = foodname
        meal.calories = calories
        meal.mood = mood
        meal.date = Date()
        meal.mealtype = mealtype
        meal.userId = userId
        
        
        save(context: context)
        
    }
}
