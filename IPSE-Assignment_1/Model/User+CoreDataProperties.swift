//
//  User+CoreDataProperties.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 1/10/2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var username: String?
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var email: String?

}

extension User : Identifiable {

}
