import SwiftUI

struct PlanningConstraintsView: View {
    
    @State var maxCookingTime: Int = 1 // minutes
    @State var numRecipes: Int = 0
    
    @Binding var rootIsActive: Bool

    var body: some View {
        
        Button("Home") {
            rootIsActive = false
        }
        
        ZStack {
            Color(.pancoNeutral)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                HeaderView1(title: "Planning", progress: 0.33)
                
                // ⭐️ Number of recipes section
                VStack {
                    Text("No. of recipes this week")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    
                    HStack {
                        // - button
                        Button {
                            if numRecipes > 0 {
                                numRecipes -= 1
                            }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundStyle(Color.pancoGreen)
                        }
                        
                        // recipe count
                        Text("\(numRecipes)")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(.horizontal, 10)
                            .foregroundStyle(.white)
                            .frame(maxWidth: 80, maxHeight: 80)
                            .background(Color.pancoGreen)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding()
                        
                        // + button
                        Button {
                            if numRecipes < 10 {
                                numRecipes += 1
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.pancoGreen)
                                .frame(width: 40)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 180)
                .background(Color.pancoLightRed.opacity(0.15))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding()
                
                // ⭐️ Time scroll section
                VStack {
                    Text("Max. time per cooking session (minutes)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Picker("Max Cooking Time", selection: $maxCookingTime) {
                        ForEach(1...120, id: \.self) { minute in
                            Text("\(minute)").tag(minute)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(Color.pancoNeutral)
                    .frame(width: 350, height: 100)
                    .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .background(Color.pancoLightRed.opacity(0.15))
                .cornerRadius(15)
                .padding()
                
                // ⭐️ Continue button
                NavigationLink {
                    PlanningRecipeView(rootIsActive: $rootIsActive)
                } label: {
                    Text("Continue")
                        .foregroundColor(.pancoNeutral)
                        .font(.headline)
                        .padding()
                        .frame(width: 180, height: 60)
                        .background(Color.pancoLightGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                }
                
            } // VStack end
            .padding(.horizontal, 20)  // Consistent horizontal padding here!
        } // ZStack end
    } // body end
} // struct end


struct HeaderView1: View {
    var title: String
    var progress: Double
    
    var body: some View {
        VStack(spacing: 8) {
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.pancoGreen))
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .frame(width: 160)
                .frame(maxWidth: .infinity, alignment: .center)
                // Removed top padding here
            
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .padding(.top, -60) // small controlled padding here if needed
    }
}



#Preview {
    PlanningConstraintsView(rootIsActive: .constant(false))
}
