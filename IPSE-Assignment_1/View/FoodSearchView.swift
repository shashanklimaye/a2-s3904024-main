import SwiftUI

/// This view uses REST API to display food items based on the value entered in the search field.
/// Users can choose the food item and proceed to Meal logging view from this screen.
struct FoodSearchView: View {
    @ObservedObject var foodItemsViewModel = FoodItemsViewModel()
    
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .padding(25)
            .background(Color.green.opacity(0.3).gradient)
            
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(.green.opacity(0.3))
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                VStack {
                    Text("Select the food Item")
                        .font(.title)
                    TextField("Search Food Item", text: $searchText, onEditingChanged: { isEditing in
                        self.isSearching = isEditing
                    })
                    .onChange(of: searchText) { newValue in
                        foodItemsViewModel.fetchFoodItems(query: newValue)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                }
                
            .frame(maxWidth: .infinity, maxHeight: 80)
            }
            
                if isSearching {
                        List(foodItemsViewModel.filteredFoodItems(searchText)) { foodItem in
                            NavigationLink(destination: MealLoggingView(foodItemName: foodItem.title)) {
                                Text(foodItem.title)
                            }
                        }
                    .transition(.scale)
                    .listStyle(.grouped)
                    .padding()
                    
                }
                Spacer()
            
        }
    
    }
}

struct FoodSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSearchView()
    }
}
