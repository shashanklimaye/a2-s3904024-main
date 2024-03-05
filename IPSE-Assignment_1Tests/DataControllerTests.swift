//
//  DataControllerTests.swift
//  IPSE-Assignment_1Tests
//
//  Created by apple on 15/10/23.
//

import XCTest
import CoreData
@testable import IPSE_Assignment_1

class DataControllerTests: XCTestCase {
    
    var dataController: DataController!
    var testContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        // Initializing in-memory Persistent Container for testing
        let modelURL = Bundle(for: DataController.self).url(forResource: "RecordModel", withExtension: "momd")!
        let mom = NSManagedObjectModel(contentsOf: modelURL)!
        
        let container = NSPersistentContainer(name: "RecordModel", managedObjectModel: mom)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (description, error) in
            XCTAssertNil(error)
        }
        testContext = container.newBackgroundContext()
        
        // Create DataController instance
        dataController = DataController()
        dataController.container = container
    }
    
    override func tearDown() {
        dataController = nil
        testContext = nil
        super.tearDown()
    }
    
    func testAddRecord() {
        let foodName = "Apple"
        let calories: Float = 95.0
        let mood = "Happy"
        let mealtype = "Snack"
        let userId = "user123"
        
        dataController.addRecord(context: testContext, foodname: foodName, calories: calories, mood: mood, mealtype: mealtype, userId: userId)
        
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "foodname == %@", foodName)
        
        do {
            let results = try testContext.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)
            let record = results.first!
            XCTAssertEqual(record.foodname, foodName)
            XCTAssertEqual(record.calories, calories)
            XCTAssertEqual(record.mood, mood)
            XCTAssertEqual(record.mealtype, mealtype)
            XCTAssertEqual(record.userId, userId)
        } catch {
            XCTFail("Fetching record failed with error: \(error)")
        }
    }
    //Test Case for Saving Data 
    func testSaveData() {
        // Test addRecord to add a food record:
        let foodName = "Banana"
        dataController.addRecord(context: testContext, foodname: foodName, calories: 105, mood: "Neutral", mealtype: "Snack", userId: "user123")
        
        // Fetch data to check whether it's saved
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "foodname == %@", foodName)
        
        do {
            let results = try testContext.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)
            let record = results.first!
            XCTAssertEqual(record.foodname, foodName)
            XCTAssertEqual(record.calories, 105)
            XCTAssertEqual(record.mood, "Neutral")
            XCTAssertEqual(record.mealtype, "Snack")
            XCTAssertEqual(record.userId, "user123")
        } catch {
            XCTFail("Fetching record failed with error: \(error)")
        }
    }

    
    func testAddRecordWithEmptyValues() {
        // Adding a record with empty values, assuming it should still save but may not be valid for business logic
        dataController.addRecord(context: testContext, foodname: "", calories: 0, mood: "", mealtype: "", userId: "")
        
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "foodname == %@", "")
        
        do {
            let results = try testContext.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)
            let record = results.first!
            XCTAssertEqual(record.foodname, "")
            XCTAssertEqual(record.calories, 0)
            XCTAssertEqual(record.mood, "")
            XCTAssertEqual(record.mealtype, "")
            XCTAssertEqual(record.userId, "")
        } catch {
            XCTFail("Fetching record failed with error: \(error)")
        }
    }

    func testAddMultipleRecords() {
        let foods = ["Apple", "Banana", "Orange"]
        for food in foods {
            dataController.addRecord(context: testContext, foodname: food, calories: 100, mood: "Happy", mealtype: "Lunch", userId: "user123")
        }
        
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        
        do {
            let results = try testContext.fetch(fetchRequest)
            XCTAssertEqual(results.count, foods.count)
            
            let fetchedFoods = results.map { $0.foodname }
            for food in foods {
                XCTAssertTrue(fetchedFoods.contains(food))
            }
            
        } catch {
            XCTFail("Fetching record failed with error: \(error)")
        }
    }

    func testDeleteRecord() {
        // Add a record
        let foodName = "Grapes"
        dataController.addRecord(context: testContext, foodname: foodName, calories: 70, mood: "Content", mealtype: "Snack", userId: "user124")
        
        // Fetch and delete the record
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "foodname == %@", foodName)
        
        do {
            let results = try testContext.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)
            
            testContext.delete(results.first!)
            try testContext.save()
            
            // Fetch again and validate the deletion
            let newResults = try testContext.fetch(fetchRequest)
            XCTAssertEqual(newResults.count, 0)
        } catch {
            XCTFail("Error in fetching or deleting the record: \(error)")
        }
    }

    func testUpdateRecord() {
        // Add a record
        let foodName = "Cherry"
        dataController.addRecord(context: testContext, foodname: foodName, calories: 50, mood: "Joyful", mealtype: "Dessert", userId: "user126")
        
        // Fetch and update the record
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "foodname == %@", foodName)
        
        do {
            var results = try testContext.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)
            
            let recordToUpdate = results.first!
            recordToUpdate.foodname = "Blueberry"
            try testContext.save()
            
            // Fetch again and validate the update
            fetchRequest.predicate = NSPredicate(format: "foodname == %@", "Blueberry")
            results = try testContext.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)
            XCTAssertEqual(results.first!.foodname, "Blueberry")
        } catch {
            XCTFail("Error in fetching or updating the record: \(error)")
        }
    }


   
}

