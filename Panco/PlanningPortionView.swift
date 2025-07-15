//
//  ContentView.swift
//  panco
//
//  Created by Victoria Dateling on 11/7/2025.
//

import SwiftUI

struct PlanningPortionView: View {
    
    let recipeCount: Int
    @State private var counters: [CounterView] = []
    
    let columns = [
        GridItem(.fixed(140), spacing:15),
        GridItem(.fixed(70), spacing:2),
        GridItem(.fixed(60), spacing:0),
        GridItem(.fixed(50), spacing:2)
    ]
    
    
    @Binding var rootIsActive : Bool
    
    var body: some View {
   
            // Background colour
            ZStack {
                Color(.pancoNeutral)
                    .ignoresSafeArea()
                
                // view components
                VStack {
                    
                    ProgressView(value: 0.9)
                        .frame(width: 160)
                        .accentColor(Color.pancoGreen)
                        .padding(.top, 20)
                    
                    Text("Portioning")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding(.trailing, 180)
                        .padding(.top, 20)
                        .padding(.bottom, 9)
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(counters, id: \.id) { counter in
                                counter
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
            .onAppear {
                for index in 1...recipeCount {
                    counters.append(CounterView(id: index))
                }
            }
        }
    }


struct CounterView: View {
    let id: Int
    @State var count: Int = 0
    
    var body: some View {
        // need to replace with images from api
        ZStack{
            Image("Recipe 1")
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(20)
                .padding(.trailing, 20)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.4))
                .frame(width: 150, height: 150)
                .padding(.trailing, 20)
        }
        
        Button {
            if count > 0 { count -= 1
                
            }
        } label: {
            Image(systemName: "minus.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.pancoGreen)
                .frame(width: 40)
        }
        
        Text("\(Int(count))")
            .fontWeight(.bold)
            .font(.largeTitle)
            .padding(.horizontal, 10)
        
        Button {if count < 10  { count += 1}
            
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
    PlanningPortionView(recipeCount: 3,rootIsActive: .constant(false))
}

