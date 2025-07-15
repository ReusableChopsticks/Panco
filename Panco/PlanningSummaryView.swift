import SwiftUI


struct PlanningSummaryView: View {
    
    @Binding var rootIsActive : Bool
    
    var body: some View {
        
        ZStack {
            // Background color
            Color(red: 245/255, green: 241/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                //                Button("Back", systemImage: "chevron.backward") {}
                //                    .foregroundColor(.pancoGreen)
                //                    .fontWeight(.semibold)
                //                    .padding(.top, 30)
                //                    .padding(.leading)
                
                Text("Summary")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.leading)
                
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            RecipeCardView(imageName: "Recipe 1", title: "Recipe 1", count: 0)
                            RecipeCardView(imageName: "Recipe 2", title: "Recipe 2", count: 0)
                            RecipeCardView(imageName: "Recipe 3", title: "Recipe 3", count: 0)
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
                        Text("waaaah")
                            .foregroundColor(Color.pancoNeutral)
                            .font(.headline)
                            .frame(width: 180, height: 60)
                            .background(Color.pancoLightGreen)
                            .clipShape(.rect(cornerRadius: 20))
                            .shadow(radius: 5)
                    }
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
            
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(20)
                .padding(20)
            
            VStack {
                Text(title)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("\(count)")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.trailing, 20)
        }
        .background(.pancoLightRed.opacity(0.15))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) //
    }
}

#Preview {
    PlanningSummaryView(rootIsActive: .constant(false))
}
