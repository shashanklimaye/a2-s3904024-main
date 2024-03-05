//
//  SplashScreenView.swift
//  IPSE-Assignment_1
//
//  Created by Ashwin on 26/08/23.
//

import SwiftUI

/// Placeholder view while the Application loads.
struct SplashScreenView: View {
    @State private var isActive: Bool = false
    @State private var apiTestResult: String = ""
    @EnvironmentObject var session: Session

    var body: some View {
        VStack {
            if isActive {
                LoginView()
                    .environmentObject(session)
            } else {
                VStack {
                    Image("itrackmyfood-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600, height: 600)
                    
                    // Display the API test result
                    Text(apiTestResult)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .onAppear {
                    
                    // Transition to LoginView after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct LoginView: View {
    @EnvironmentObject var session: Session
    
    var body: some View {
        LoginRegisterView()
            .environmentObject(session)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .environmentObject(Session())
    }
}

