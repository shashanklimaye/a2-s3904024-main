//
//  Login:Register.swift
//  iPSE-Assignment_1
//
//  Created by Ashwin on 21/08/23.
//

import SwiftUI
import Auth0

/// This is the Login and Register screen of the application.
/// User can create an account or login to an existing account using Auth0 to login into the App.
struct LoginRegisterView: View {
   
    @FetchRequest(sortDescriptors:[],predicate: NSPredicate(format: "date >= %@", Calendar.current.startOfDay(for: Date()) as NSDate)) var todayMeals : FetchedResults<Record>
    @EnvironmentObject var session : Session
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    Image("itrackmyfood-logo")
                        .resizable()
                        .scaledToFit()
                    
                    
                }
                Button(action:{
                    session.login()}) {
                    Text("Login" )
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                Spacer()
                
                
                
            }
            .padding()
        }
    }
}

struct LoginRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterView()
    }
}
