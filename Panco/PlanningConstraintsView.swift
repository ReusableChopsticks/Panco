// PlanningConstraintsView: User inputs their availability and requirements
// Created by: Nikki on 14 July
// Last edited by: Nikki on 14 July 9.30PM (Sent)

import SwiftUI

struct PlanningConstraintsView: View {
    
    @State var maxCookingTime: Int = 1 //minutes
    @State var noRecipes: Int = 0
    //    @State private var removeCount: Int = 0
    //    @State private var addCount: Int = 0
    
    
    var body: some View {
        NavigationStack {
            
            
            ZStack {
                Color(.pancoNeutral)
                    .ignoresSafeArea()
                
                VStack{
                    
                    // Progress bar
                    HStack{
                        Spacer()
                        ProgressView(value: 0.33)
                            .frame(width: 160)
                            .accentColor(Color.pancoGreen)
                        Spacer()
                    }
                    
                    // ⭐️ Page title
                    Text("Planning")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding(.trailing, 180)
                        .padding(.top, 20)
                    
                    
                    // ⭐️ Number of recipe
                    VStack{
                        Text("No. of recipes this week")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                        
                        HStack{
                            // - button
                            Button {
                                if noRecipes > 0 {
                                    noRecipes -= 1
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                
                                    .frame(width: 40)
                                    .foregroundStyle(Color.pancoGreen)
                                
                                
                                
                                // recipe count
                                Text("\(Int(noRecipes))")
                                    .fontWeight(.bold)
                                    .font(.largeTitle)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth:80, maxHeight: 80)
                                    .background(.pancoGreen)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                    .padding()
                                
                                
                                // + button
                                Button{
                                    if noRecipes < 10 {
                                        noRecipes += 1
                                    }
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(Color.pancoGreen)
                                        .frame(width: 40)
                                }
                            }//HStack end
                            
                        }//VStack end
                        
                    }// VStack no. recipe section end
                    .frame(maxWidth: .infinity, maxHeight: 180)
                    .background(.pancoLightRed.opacity(0.15))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding()
                    
                    
                    // ⭐️ Time scroll
                    VStack{
                        
                        Text("Max. time per cooking session (minutes)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(width: 300, height: 50)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        
                        
                        Picker("Max Cooking Time", selection: $maxCookingTime)
                        {
                            // Generate any range you like—here, 1 min up to 120 min.
                            ForEach(1...120, id: \.self)
                            {
                                minute in
                                Text("\(minute)").tag(minute)
                            }
                            
                        }
                        
                        .pickerStyle(.wheel)// gives you the spinning “slot‑machine” look
                        .background(Color.pancoNeutral)
                        .frame(width:350, height: 100)// optional: keeps the wheel a nice compact height
                        .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .background(.pancoLightRed.opacity(0.15))
                    .cornerRadius(15)
                    .padding()
                    
                    // ⭐️ Continue button
                    NavigationLink {
                        PlanningRecipeView()  // ← Destination
                    } label: {
                        Text("Continue")      // ← Label with button styling
                            .foregroundColor(.pancoNeutral)
                            .font(.headline)
                            .padding()
                            .frame(width: 180, height: 60)
                            .background(.pancoLightGreen)
                            .cornerRadius(20)
                            .padding(.top, 20)
                            .padding(.bottom, 50)
                            .shadow(radius: 5)
                    }
                }//VStack end
            }//ZStack end
        }//NavigationStack end
    } //body end
}//struct end

#Preview {
    PlanningConstraintsView()
}
