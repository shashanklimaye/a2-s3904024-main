//
//  ProfileView.swift
//  IPSE-Assignment_1
//
//  Created by Shashank Limaye on 21/8/2023.
//

import SwiftUI
import URLImage

/// The User Profile is visible in the view. User can interact with user settings and logout of the application from this view.
struct ProfileView: View {
    
    @EnvironmentObject var session : Session
    @EnvironmentObject var calorieTracker : CalorieManager
    @EnvironmentObject var userDefaults : UserDefaultsClass
    
    
    @State var isTrackCaloriesEnabled = UserDefaults.standard.bool(forKey: "isTrackCaloriesEnabled")
    @State private var calorieCount: Double = 0
    @State var isDietSuggestionsEnabled = UserDefaults.standard.bool(forKey: "isDietSuggestionsEnabled")
    @State private var showAlert: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Profile INFO")){
                    HStack{
                        AsyncImage(url: URL(string: session.userProfile.picture)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100) // Adjust size as needed
                                .clipShape(Circle())
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100) // Adjust size as needed
                                .clipShape(Circle())
                        }
                        .frame(width: 100, height: 100) // Adjust size as needed
                        .clipShape(Circle())
                        VStack(alignment:.leading){
                            Text("\(session.userProfile.name)")
                                .font(.callout)
                                .foregroundColor(.black)
                            Text("\(session.userProfile.email)")
                                .font(.footnote)
                                .foregroundColor(.green)
                        }
                        
                    }
                    
                }
                
                Section(header: Text("Calorie Tracking")){
                    Toggle("Enable Calorie Tracking", isOn: $isTrackCaloriesEnabled)
                        .onChange(of: isTrackCaloriesEnabled) { value in
                            userDefaults.setTrackCaloriesEnabled(isTrackCaloriesEnabled: value)
                        }
                    
                    HStack {
                        Spacer()
                        Text("Calories : \(Int(calorieCount))")
                        Spacer()
                    }
                    Slider(value: $calorieCount,in: 0...5000, step: 50)
                        .disabled(!isTrackCaloriesEnabled)
                    HStack {
                        Spacer()
                        Button("Set Calorie Count") {
                            calorieTracker.setCalorieCount(Int(calorieCount))
                            showAlert.toggle()
                        }
                        .disabled(!isTrackCaloriesEnabled)
                        .buttonStyle(.borderedProminent)
                        .cornerRadius(12)
                        
                        Spacer()
                    }
                    .padding()
                    
                    
                    
                    
                }
                Section(header: Text("other preferences")){
                    
                    Toggle("Enable Diet Suggestions", isOn: $isDietSuggestionsEnabled)
                        .onChange(of: isDietSuggestionsEnabled) { value in
                            userDefaults.setDietSuggestionsEnabled(isDietSuggestionsEnabled: value)
                        }
                }
                Section(header: Text("Account")){
                        
                        Button(action:{
                            async{
                                await session.logout()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }){Text("Logout")}
                    }
                }
                .navigationTitle("PROFILE & SETTINGS")
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Calories Target Set"), message: Text("Your daily calorie target is set!"), dismissButton: .default(Text("OK")))
                    
                }
            }
        }
        
        struct ProfileView_Previews: PreviewProvider {
            static var previews: some View {
                ProfileView()
            }
        }}
