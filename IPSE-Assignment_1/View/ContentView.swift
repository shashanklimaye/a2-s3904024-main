//
//  ContentView.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 21/8/2023.
//

import SwiftUI

/// Default view of the Application.
/// All the view are stacked on to this View.
struct ContentView: View {
    
    @EnvironmentObject var session : Session
    
    var body: some View {
        Group {
            NavigationStack {
                if session.isLoggedIn {
                    HomePageView()
                    
                }
                else{
                    SplashScreenView()
                   // APIService()
                }
                
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



