import SwiftUI

// Data Model
struct GroceryItem: Identifiable {
    let id = UUID()
    let quantity: String
    let name: String
    var isChecked: Bool = true
}

// Row View
struct GroceryRowView: View {
    @Binding var item: GroceryItem
    // Removed rootIsActive since it wasn’t used in the row
    var body: some View {
        HStack(spacing: 15) {
            // Checkbox Icon
            Image(systemName: item.isChecked ? "checkmark.square.fill" : "square")
                .font(.title2)
                .foregroundColor(Color.pancoGreen)
                .onTapGesture {
                    item.isChecked.toggle()
                }
            
            (
                Text(item.quantity)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.pancoGreen)
                + Text(" \(item.name)")
                    .font(.title3)
            )
            .padding(.vertical, 20)
            
            Spacer()
        }
        .padding(.top,5)
        .padding(.bottom,5)
        .padding(.horizontal, 20)
        .background(Color.pancoLightRed.opacity(0.15))
        .cornerRadius(15)
    }
}

// Main View
struct PlanningGroceryView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    @State private var groceryItems: [GroceryItem] = [
        .init(quantity: "100 grams", name: "Beef Mince"),
        .init(quantity: "1 cup", name: "All purpose flour"),
        .init(quantity: "3", name: "Eggs"),
        .init(quantity: "1 bunch", name: "Spring onions"),
        .init(quantity: "2", name: "Tomatoes"),
    ]
    
    @Binding var rootIsActive: Bool

    var body: some View {
        ZStack {
            Color.pancoNeutral
                .ignoresSafeArea()
            
            VStack {
                // Header
                Text("Grocery List")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.trailing, 180)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                // SubHeader
                Text("Grocery List")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding(.trailing, 270)
                    .padding(.bottom, 10)
                
                
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach($groceryItems) { $item in
                            GroceryRowView(item: $item)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Navigation Button
                Button {
                    rootIsActive = false
                    recipeManager.notEmpty = true
                } label: {
                    Text("Done")
                        .foregroundColor(Color.pancoNeutral)
                        .font(.headline)
                        .frame(width: 180, height: 60)
                        .background(Color.pancoGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                }

//                NavigationLink {
//                    FilledPlanView(
//                        groceryList: "From Grocery View",
//                        chosenRecipes: "",
//                        rootIsActive: $rootIsActive
//                    )
//                } label: {
//                    Text("Done")
//                        .foregroundColor(Color.pancoNeutral)
//                        .font(.headline)
//                        .frame(width: 180, height: 60)
//                        .background(Color.pancoLightGreen)
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .shadow(radius: 5)
//                }
//                .padding(.bottom, 30)
            }
        }
        // Share button in nav bar
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Add share functionality here
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        PlanningGroceryView(rootIsActive: .constant(true)).environment(RecipeManager())
    }
}
