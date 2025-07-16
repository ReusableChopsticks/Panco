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
extension String: @retroactive Identifiable {
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
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    //    var selectedRecipes: [String] = ["Chicken Rice", "R2", "R3", "R4", "R5"]
    @Binding var rootIsActive : Bool
    
//    let groceryList: String
//    let chosenRecipes: String
    
    
    
    
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
        HeaderViewSimple(title: "Plans", rootIsActive: $rootIsActive)
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
                    //                    if !groceryList.isEmpty {
                    //                        Image(systemName: "exclamationmark.circle.fill")
                    //                            .resizable()
                    //                            .frame(width: 30, height: 30)
                    //                            .foregroundStyle(.pancoRed)
                    //                    }
                }
                .padding(.horizontal)
                .frame(height: 70)
                .background(.pancoLightRed)
                .cornerRadius(30)
                .shadow(radius: 5)
                
            }
        }
        .padding(.horizontal)
    }
    
    var sampleRecipes: [RecipesResult] = [
        Panco.RecipesResult(id: 715421, title: "Cheesy Chicken Casserole", image: "CheesyChicken", imageType: "jpg"),
        Panco.RecipesResult(id: 782601, title: "Fish Tacos", image: "FishTacos", imageType: "jpg")
    ]
    
    var recipeGrid: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.fixed(150), spacing: 40),
                    GridItem(.fixed(150), spacing: 40)
                ],
                spacing: 2
            ) {
                ForEach(sampleRecipes, id: \.id) { recipe in
                    Button {
                        selectedRecipeName = recipe.title
                    } label: {
                        HardCodedRecipe(recipe: recipe)
                            .frame(width: 170, height: 170)
                            .padding(10)
                    }
                
//                    With proper data from API
//                ForEach(recipeManager.mealPlan, id: \.id) { portion in
//                    Button {
//                        selectedRecipeName = portion.recipe.title
//                    } label: {
//                        ShowRecipe(portion: portion)
//                        .frame(width: 170, height: 170)
//                        .padding(10)
//                    }


//                    Button {
//                        selectedRecipeName = recipe.recipe.title
//                    } label: {
//                        ZStack(alignment: .bottomLeading) {
//                            RoundedRectangle(cornerRadius: 20)
//                                .fill(Color.gray.opacity(0.3))
//                                .frame(width: 170, height: 170)
//                            
//                            Text(recipe.recipe.title)
//                                .font(.title3.bold())
//                                .foregroundColor(.white)
//                                .padding(10)
//                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//                        }
//                    }
//                    .frame(width: 170, height: 170)
//                    .padding(10)
//                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
    
    
    var newPlanButton: some View {
        Button("New Plan") {
            rootIsActive.toggle()
        }
        .foregroundColor(.pancoNeutral)
        .font(.headline)
        .padding()
        .frame(width: 180, height: 60)
        .background(Color.pancoRed)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
    
    var ingredientsPopover: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(selectedRecipeName ?? "").font(.title).bold(true)
            
            Link("View recipe online",
                 destination: URL(string: "https://www.allrecipes.com/recipe/80934/fairy-bread/")!).padding(.bottom, 20)
            
            Text("Ingredients").font(.title3).bold(true)
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

struct HardCodedRecipe: View {
    let recipe: RecipesResult
    var body: some View {
        ZStack{
            Image(recipe.image)
                .resizable()
            .frame(width: 170, height: 170)
            .cornerRadius(20)

            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.4))
                .frame(width: 170, height: 170)
  
            
            Text(recipe.title)
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(10)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 150, maxHeight: 150, alignment: .bottomLeading)
        }
    }
}

struct ShowRecipe: View {
    let portion: PortionModel
    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: portion.recipe.image)) { img in
                img.resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 170, height: 170)
            .cornerRadius(20)

            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.4))
                .frame(width: 170, height: 170)
  
            
            Text(portion.recipe.title)
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(10)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 150, maxHeight: 150, alignment: .bottomLeading)
        }
    }
}

struct HeaderViewSimple: View {
    let title: String
    @Binding var rootIsActive: Bool  // pass binding for navigation
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            
            
            
            NavigationLink (destination: PlanningConstraintsView(rootIsActive: $rootIsActive), isActive: $rootIsActive) {
                //‼️Can we change this as it gets lost in the layout
                Button("Edit") {}
                    .foregroundColor(Color.pancoNeutral)
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 70, height: 35)
                    .background(Color.pancoLightRed)
                    .cornerRadius(30)
                    .shadow(radius: 2)
                
                    
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
}


// MARK: - Preview

#Preview {
    NavigationStack {
        FilledPlanView(
            rootIsActive: .constant(true),
//            groceryList: "Rice, Eggs",
//            chosenRecipes: "Chicken Rice, Soup",
        ).environment(RecipeManager())
    }
}
