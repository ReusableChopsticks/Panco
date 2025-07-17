
//  ContentView.swift
//  panco
//
//  Created by Victoria Dateling on 11/7/2025.
//

import SwiftUI

struct PlanningPortionView: View {
    @Environment(RecipeManager.self) var recipeManager: RecipeManager
    
    @State private var counters: [CounterView] = []
    let recipeCount: Int
    
    let columns = [
        GridItem(.fixed(140), spacing:15),
        GridItem(.fixed(70), spacing:2),
        GridItem(.fixed(60), spacing:0),
        GridItem(.fixed(50), spacing:2)
    ]
    
    let rows = [
        GridItem(.fixed(190)),  // height of each row
        GridItem(.fixed(190))
    ]
    
    @Binding var rootIsActive : Bool
    
    var body: some View {
        ZStack {
            Color(.pancoNeutral)
                .ignoresSafeArea()
            
            // view components
            VStack {
                
                HStack {
                    Spacer()
                    ProgressView(value: 0.33)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.pancoGreen))
                        .scaleEffect(x: 1, y: 2, anchor: .center) // ⬅️ Makes the bar 3x taller
                        .frame(width: 160)
                    
                    Spacer()
                }
                
                
                // ⭐️ Page title
                HStack {
                    Text("Portion")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    Spacer()
                }
                .padding(.horizontal,20)
                
                ZStack {
                    
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(recipeManager.mealPlan, id: \.id) { portion in
                                CounterView(recipePortion: portion)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }
                NavigationLink {
                    PlanningSummaryView(rootIsActive: $rootIsActive)
                } label: {
                    Text("Continue")
                        .foregroundColor(.pancoNeutral)
                        .font(.headline)
                        .frame(width: 180, height: 60)
                        .background(Color.pancoGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                }
            }
        }
    }
    
    
    struct CounterView: View {
        var recipePortion: PortionModel
        
        var body: some View {
            HStack {
                // Image
                AsyncImage(url: URL(string: recipePortion.recipe.image)) { img in
                    img.resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 140, height: 140)
                .cornerRadius(20)
                .padding(.leading, 20)
                
                VStack() {
                    Text(recipePortion.recipe.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            if recipePortion.portion > 1 {
                                recipePortion.decrementPortion()
                            }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.pancoGreen)
                                .frame(width: 40)
                        }
                        .padding(.leading, 10)
                        .padding(.bottom, 15)
                        
                        Text("\(Int(recipePortion.portion))")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(.horizontal, 10)
                            .foregroundStyle(.white)
                            .frame(width: 70, height: 70)
                            .background(Color.pancoGreen)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(5)
                            .padding(.bottom, 15)
                        
                        Button {
                            if recipePortion.portion < 10 {
                                recipePortion.incrementPortion()
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.pancoGreen)
                                .frame(width: 40)
                        }
                        .padding(.bottom, 15)
                    }
                
                 

                }
        
                .padding(.vertical, 10)
            }
            .background(Color.pancoLightRed.opacity(0.15))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .frame(width: 375, height: 190)
        }
    
    }

}


#Preview {
    PlanningPortionView(recipeCount: 3,rootIsActive: .constant(false)).environment(RecipeManager())
}

