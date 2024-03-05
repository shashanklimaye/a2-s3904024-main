//
//  Session.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 27/8/2023.
//

import Foundation
import Auth0


/// Observable class Session to store user information and handle authentication.
class Session: ObservableObject {

    /// user login state
    @Published  var isLoggedIn : Bool = false
    
    /// user profile variable
    @Published var userProfile : UserProfile = UserProfile.empty
    
    /// Logs the user into the system and sets user defaults and login state of the user.
    /// UserProfile is set in this method in case of success.
    func login(){
        Auth0
            .webAuth()
            .start { result in
                switch result {
                    
                case .success(let credentials):
                    // Handle successful authentication
                    self.isLoggedIn = true
                    self.userProfile = UserProfile.from(credentials.idToken)
                    UserDefaults.standard.set(self.userProfile.userId, forKey: "UserId")
                    UserDefaults.standard.set(true, forKey: "isDietSuggestionsEnabled")
                    UserDefaults.standard.set(true, forKey: "isTrackCaloriesEnabled")
                    
                case .failure(let error):
                    // Handle authentication failure
                    print("Error: \(error)")
                }
            }
    }
    
    /// Logs the user out of the system and sets user defaults and login state of the user to nil.
    /// UserProfile is set to empty in this method in case of success.
    func logout() async {
        Auth0
            .webAuth()
            .clearSession{ result in
                switch result {
                    
                case .success:
                    // Handle successful authentication
                    self.isLoggedIn = false
                    self.userProfile = UserProfile.empty
                    UserDefaults.standard.set("", forKey: "UserId")
                    UserDefaults.standard.set(0, forKey: "TargetCalories")
                    
                case .failure(let error):
                    // Handle authentication failure
                    print("Error: \(error)")
                }
            }
    }
}
