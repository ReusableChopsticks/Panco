import SwiftUI


struct PlanningSummaryView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    @Binding var rootIsActive : Bool
    
    var body: some View {
        
        ZStack {
            // Background color
            Color(red: 245/255, green: 241/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Summary")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.leading)
                
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            
                            ForEach(recipeManager.mealPlan, id: \.id) { portion in
                                RecipeCardView(imageName: portion.recipe.image, title: portion.recipe.title, count: portion.portion)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 100)
                    }
                    
                    //                    // Floating button above scroll
                    //                    Button("Save") {}
                    //                        .foregroundColor(.pancoNeutral)
                    //                        .font(.headline)
                    //                        .padding()
                    //                        .frame(width: 180, height: 60)
                    //                        .background(.pancoGreen)
                    //                        .cornerRadius(20)
                    //                        .shadow(radius: 5)
                    //                        .padding(.horizontal, 100)
                    //                        .padding(.bottom, 30)
                    
                    NavigationLink() {
                        PlanningGroceryView(rootIsActive: $rootIsActive)
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.pancoNeutral)
                            .font(.headline)
                            .frame(width: 180, height: 60)
                            .background(Color.pancoGreen)
                            .clipShape(.rect(cornerRadius: 20))
                            .shadow(radius: 5)
                    }.onTapGesture {
                        let newHistory: MealPlanHistoryModel = MealPlanHistoryModel(id: UUID(), date: Date(), history: recipeManager.mealPlan)
                        recipeManager.history.append(newHistory)
                    }
                    
                    .padding(.bottom, 40)
                }
            }
        }
    }
}


struct RecipeCardView: View {
    var imageName: String
    var title: String
    var count: Int
    
    var body: some View {
        
        
        HStack {
            
            AsyncImage(url: URL(string: imageName)) { img in
                img.resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 150, height: 150)
            .cornerRadius(20)
            .padding(.leading, 10)
            
            VStack {
                Text(title)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
                
                Spacer()
                
                Text("Portions: \(count)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }.padding(.vertical, 11).padding(.trailing, 20)
        }
        .background(.pancoLightRed.opacity(0.15))
        .frame(width: 375, height: 190)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) //
    }
}

#Preview {
    PlanningSummaryView(rootIsActive: .constant(false)).environment(RecipeManager())
}
