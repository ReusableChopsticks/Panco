import SwiftUI

// MARK: - Helpers

/// Formats 1.0 → “1”, 200.0 → “200”
private extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", self)
        : String(self)
    }
}

/// Makes `String` usable with `.popover(item:)`
extension String: Identifiable {
    public var id: String { self }
}

// MARK: - Data model for the pop‑over list

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let unit: String
}

// MARK: - Main View

struct FilledPlanView: View {
    var selectedRecipes: [String] = ["Chicken Rice", "R2", "R3", "R4", "R5"]
    let groceryList: String
    let chosenRecipes: String
    
    @Binding var rootIsActive: Bool
    
    private let columns = [
        GridItem(.fixed(150), spacing: 40),
        GridItem(.fixed(150), spacing: 40)
    ]
    
    @State private var selectedRecipeName: String?
    
    private let sampleIngredients: [Ingredient] = [
        .init(name: "Chicken",   amount: 200, unit: "g"),
        .init(name: "Rice",      amount: 1,   unit: "cup"),
        .init(name: "Onion",     amount: 1,   unit: "unit"),
        .init(name: "Coriander", amount: 50,  unit: "g"),
        .init(name: "Cucumber",  amount: 1,   unit: "unit"),
        .init(name: "Soy Sauce", amount: 1,   unit: "tbsp")
    ]
    
    var body: some View {
        ZStack {
            Color(.pancoNeutral).ignoresSafeArea()
            
            VStack {
                header
                ScrollView {
                    groceryListTab
                    recipeGrid
                }
                newPlanButton
            }
        }
        .popover(item: $selectedRecipeName) { _ in
            ingredientsPopover
        }
    }

    var header: some View {
        HStack {
            Text("Plans")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.trailing, 200)
            
            NavigationLink {
                PlanningConstraintsView(rootIsActive: $rootIsActive)
            } label: {
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(.pancoRed)
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 50)
    }

    var groceryListTab: some View {
        ZStack(alignment: .leading) {
            NavigationLink {
                PlanningGroceryView(rootIsActive: $rootIsActive)
            } label: {
                HStack {
                    Text("Grocery List")
                        .foregroundColor(.pancoNeutral)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.compact.forward")
                        .resizable()
                        .frame(width: 15, height: 20)
                        .foregroundStyle(.pancoNeutral)
                    
                    // Example logic: show exclamation mark only if list not empty
                    if !groceryList.isEmpty {
                        Image(systemName: "exclamationmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.pancoRed)
                    }
                }
                .padding(.horizontal)
                .frame(height: 45)
                .background(.pancoLightRed)
                .cornerRadius(30)
                .shadow(radius: 5)
                .padding(.top, 20)
            }
        }
        .padding(.horizontal)
    }

    var recipeGrid: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(selectedRecipes, id: \.self) { name in
                Button {
                    selectedRecipeName = name
                } label: {
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 170, height: 170)
                            .padding(10)
                        
                        Text(name)
                            .font(.title3)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(6)
                            .padding(.leading, 15)
                            .padding(.bottom, 10)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
    }

//    var newPlanButton: some View {
//        NavigationLink {
//            PlanningConstraintsView(rootIsActive: $rootIsActive)
//        } label: {
//            Text("New Plan")
//                .foregroundColor(.pancoNeutral)
//                .font(.headline)
//                .padding()
//                .frame(width: 180, height: 60)
//                .background(.pancoRed)
//                .cornerRadius(20)
//                .shadow(radius: 5)
//        }
//        .padding(.top, 20)
//    }
    
    var newPlanButton: some View {
        Button("tets") {
            rootIsActive.toggle()
        }
    }

    var ingredientsPopover: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(sampleIngredients) { item in
                Text("\(item.name): \(item.amount.clean) \(item.unit)")
            }
            Divider()
            Button("Close") {
                selectedRecipeName = nil
            }
            .padding(.top, 8)
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FilledPlanView(
            groceryList: "Rice, Eggs",
            chosenRecipes: "Chicken Rice, Soup",
            rootIsActive: .constant(true)
        )
    }
}
