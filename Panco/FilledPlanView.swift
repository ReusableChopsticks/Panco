import SwiftUI

// MARK: - Helpers

private extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", self)
        : String(self)
    }
}

extension String: @retroactive Identifiable {
    public var id: String { self }
}

// MARK: - Models

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let unit: String
}

// MARK: - Main View

struct FilledPlanView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    @Binding var rootIsActive: Bool
    @State private var selectedRecipeName: String?
    @State private var showCookingView = false

    private let sampleIngredients: [Ingredient] = [
        .init(name: "Chicken", amount: 2, unit: "breasts"),
        .init(name: "Cheese", amount: 1, unit: "cup"),
        .init(name: "Rice", amount: 1, unit: "cup"),
        .init(name: "Onion", amount: 1, unit: "unit"),
        .init(name: "Broccoli Florets", amount: 2, unit: "cups"),
//        .init(name: "Coriander", amount: 50, unit: "g"),
        .init(name: "Garlic", amount: 4, unit: "cloves"),
        .init(name: "Soy Sauce", amount: 1, unit: "tbsp")
    ]

    var sampleRecipes: [RecipesResult] = [
        Panco.RecipesResult(id: 715421, title: "Cheesy Chicken Casserole", image: "ChickenCasserole", imageType: "jpg"),
        Panco.RecipesResult(id: 782601, title: "Fish Tacos", image: "FishTacos", imageType: "jpg")
    ]

    var body: some View {
        ZStack {
            Color(.pancoNeutral).ignoresSafeArea()

            VStack {
                HeaderViewSimple(title: "Current Plan", rootIsActive: $rootIsActive)

                ScrollView {
                    groceryListTab

                    LazyVGrid(columns: [
                        GridItem(.fixed(150), spacing: 40),
                        GridItem(.fixed(150), spacing: 40)
                    ]) {
                        ForEach(sampleRecipes, id: \.id) { recipe in
                            Button {
                                selectedRecipeName = recipe.title
                            } label: {
                                HardCodedRecipe(recipe: recipe)
                                    .frame(width: 170, height: 170)
                                    .padding(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

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
        }
        .popover(item: $selectedRecipeName) { _ in
            ingredientsPopover
        }
        .fullScreenCover(isPresented: $showCookingView) {
            StartCooking(rootIsActive: $rootIsActive)
        }
    }

    var groceryListTab: some View {
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
            }
            .padding(.horizontal)
            .frame(height: 60)
            .background(.pancoLightRed)
            .cornerRadius(30)
            .shadow(radius: 5)
        }
        .padding(.horizontal)
    }

    var ingredientsPopover: some View {
        ZStack {
            Color.pancoNeutral.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(selectedRecipeName ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        selectedRecipeName = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.pancoGreen)
                    }
                }
                
                Image("ChickenCasserole")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: 210)
                    .clipped()
                    .cornerRadius(12)

//                Link is hard coded to fairy bread for now haha
                Link("View recipe online", destination: URL(string: "https://www.allrecipes.com/recipe/80934/fairy-bread/")!)
                    .font(.subheadline)
                    .foregroundColor(.pancoGreen)
                    .padding(.bottom, 8)

                Text("Ingredients")
                    .font(.title3)
                    .fontWeight(.semibold)

                ForEach(sampleIngredients) { item in
                    Text("• \(item.name): \(item.amount.clean) \(item.unit)")
                        .font(.body)
                }

                Spacer()

                HStack {
                    Spacer()
                    Button {
                        selectedRecipeName = nil
                        showCookingView = true
                    } label: {
                        Text("Start Cooking")
                            .foregroundColor(.pancoNeutral)
                            .font(.headline)
                            .frame(width: 180, height: 60)
                            .background(Color.pancoGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
                    }
                    Spacer()
                }
                .padding(.vertical)
            }
            .padding()
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            .frame(width: 350)
        }
    }
}

// MARK: - Subviews

struct HardCodedRecipe: View {
    let recipe: RecipesResult
    var body: some View {
        ZStack {
            Image(recipe.image)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 170)
                .cornerRadius(20)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.4))
                .frame(width: 170, height: 170)
            Text(recipe.title)
                .font(.body.bold())
                .foregroundColor(.white)
                .padding(10)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 150, maxHeight: 150, alignment: .bottomLeading)
        }
    }
}

struct HeaderViewSimple: View {
    let title: String
    @Binding var rootIsActive: Bool

    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            NavigationLink(destination: PlanningConstraintsView(rootIsActive: $rootIsActive), isActive: $rootIsActive) {
                Button("Edit") {}
                    .foregroundColor(.pancoNeutral)
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
        FilledPlanView(rootIsActive: .constant(true))
            .environment(RecipeManager())
    }
}
