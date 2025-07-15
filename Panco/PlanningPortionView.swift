//
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
    
    
    @Binding var rootIsActive : Bool
    
    var body: some View {
//        Button("Debug print") {
//            recipeManager.mealPlan.forEach { print($0.portion) }
//        }
   
            // Background colour
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
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
//                            ForEach(counters, id: \.id) { counter in
//                                counter
//                            }
                            
                            ForEach(recipeManager.mealPlan, id: \.id) { portion in
                                CounterView(recipePortion: portion)
                            }
                        }
                    }
                    
                    NavigationLink() {
                        PlanningSummaryView(rootIsActive: $rootIsActive)
                    } label: {
                        Text("Continue")
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


struct CounterView: View {
//    let id: Int
    var recipePortion: PortionModel
//    @State private var count: Int = 1
    
    var body: some View {
        // need to replace with images from api
        ZStack{
            AsyncImage(url: URL(string: recipePortion.recipe.image)) { img in
                img.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
                .frame(width: 150, height: 150)
                .cornerRadius(20)
                .padding(.trailing, 20)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.4))
                .frame(width: 150, height: 150)
                .padding(.trailing, 20)
            
            Text(recipePortion.recipe.title)
                .font(.title3.bold())
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: 150, maxHeight: 150, alignment: .bottomLeading)
        }
        
        Button {
            if recipePortion.portion > 0 {
//                recipePortion.portion -= 1
                recipePortion.decrementPortion()
            }
        } label: {
            Image(systemName: "minus.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.pancoGreen)
                .frame(width: 40)
        }
        
        Text("\(Int(recipePortion.portion))")
            .fontWeight(.bold)
            .font(.largeTitle)
            .padding(.horizontal, 10)
        
        Button {
            if recipePortion.portion < 10 {
//                count += 1
                recipePortion.incrementPortion()
            }
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.pancoGreen)
                .frame(width: 40)
                .padding(.leading, 25)
        }
    }
}



#Preview {
    PlanningPortionView(recipeCount: 3,rootIsActive: .constant(false)).environment(RecipeManager())
}

