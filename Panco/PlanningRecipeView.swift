
// PlanningRecipeView: For users to select recipes for the week
// Created by: Jannalyn Tan on 14 July
// Last edited by: Nikki on 14 July 9.30PM (Sent)

import SwiftUI

struct PlanningRecipeView: View {
    
    
    let columns = [
        GridItem(.fixed(150), spacing: 40),
        GridItem(.fixed(150), spacing: 40)
    ]
    
    
    var imageNames: [String] = ["Recipe 1", "Recipe 2", "Recipe 3", "Recipe 4", "Recipe 5"]
    
    
    @State var selectedImages: Set<String> = []
    
    @Binding var rootIsActive : Bool

    var body: some View {
            ZStack {
                // Background color
                Color(.pancoNeutral)
                    .ignoresSafeArea()
                
                
                
                VStack(alignment: .leading , spacing: 16) {
                    Text("\(selectedImages.count)")
                    VStack{ // Page title and progress bar group
                        HStack {
                            Spacer()
                            ProgressView(value: 0.66)
                                .frame(width: 160)
                                .accentColor(Color.pancoGreen)
                            Spacer()
                        }
                        
                        Text("Meals")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(.trailing, 200)
                            .padding(.top, 20)
                    }.padding(.top,20)
                    
                    HStack{
                        Button("Surprise Me") {
                            // Clear any previous selections
                            selectedImages.removeAll()
                            
                            // Randomly choose 2 or 3 recipes have to change this to choose the number of recipes in
                            let numberToSelect = 3
                            let randomSelection = imageNames.shuffled().prefix(numberToSelect)
                            
                            // Add them to the selected set
                            selectedImages = Set(randomSelection)
                        }
                        .foregroundColor(Color.pancoNeutral)
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 260, height: 70)
                        .background(Color.pancoGreen)
                        .cornerRadius(20)
                        .shadow(radius: 2)
                        
                        
                        Button(action: {
                            // Shuffle action
                        }) {
                            Image(systemName: "shuffle")
                                .font(.title2)
                                .foregroundColor(.pancoNeutral)
                        }
                        .foregroundColor(Color.pancoNeutral)
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 90, height: 70)
                        .background(Color.pancoGreen)
                        .cornerRadius(20)
                        .shadow(radius: 2)
                    }
                    .padding(.leading,20)
                    .padding(.top,20)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(imageNames, id: \.self) { name in
                                ZStack(alignment: .bottomLeading) {
                                    Image(name)
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                        .cornerRadius(20)
                                    
                                    // Overlay
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.black.opacity(0.4))
                                        .frame(width: 170, height: 170)
                                    
                                    // Text
                                    Text(name)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(6)
                                        .padding(.leading, 10)
                                        .padding(.bottom, 10)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    
                                    
                                    
                                    if selectedImages.contains(name) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 26))
                                            .fontWeight(.bold)
                                            .foregroundColor(.pancoNeutral)
                                            .offset(x: -10, y: 10)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.pancoRed, lineWidth: 5)
                                            .frame(width: 170, height: 170)
                                    }
                                    
                                }
                                
                                .frame(width: 170, height: 170)
                                .padding(10)
                                .onTapGesture {
                                    if selectedImages.contains(name) {
                                        selectedImages.remove(name)
                                        
                                    } else {
                                        selectedImages.insert(name)
                                    }
                                }
                                
                            }
                            
                            ZStack(alignment: .bottomLeading) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black.opacity(0.8))
                                    .frame(width: 170, height: 170)
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.pancoNeutral)
                                    .background(
                                        Circle()
                                            .fill(Color.pancoGreen)
                                            .frame(width: 50, height: 50)
                                    )
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                
                                // Text at bottom like other cards
                                Text("Favourites")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(6)
                                    .padding(.leading, 10)
                                    .padding(.bottom, 10)
                            }
                            .frame(width: 170, height: 170)
                            .padding(10)
                        }
                    }
                    
                }
                VStack {
                    Spacer()
                    //‼️ NAVIGATE to PlanningPortionView
                    if (selectedImages.count > 0) {
                        NavigationLink {
                            PlanningPortionView(recipeCount: selectedImages.count, rootIsActive: $rootIsActive)
                        } label: {
                            Text("Continue")
                        }
                        .foregroundColor(.pancoNeutral)
                        .font(.headline)
                        .frame(width: 180, height: 60)
                        .background(Color.pancoLightGreen)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding(.bottom, 30)
                    } else {
//                        some temporary styling for a disabled button
                        Text("Continue")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .frame(width: 180, height: 60)
                            .background(Color.pancoNeutral)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.bottom, 30)
                            .disabled(true)
                    }
                }
                
            }
        }
    }





#Preview {
    PlanningRecipeView(rootIsActive: .constant(false))
}
