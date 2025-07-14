// EmptyPlanView: Display user's empty meal plan
// Created by: Nikki on 14 July
// Last edited by: Nikki on 14 July 9.30PM (Sent)

import SwiftUI

struct EmptyPlanView: View {
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                //Background color
                Color(.pancoNeutral)
                            .ignoresSafeArea()
                
                VStack{
                    Text("Plans")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding(.trailing, 200)
                        .padding(.top, 50)
                    
                    // ⭐️ Panco speech bubble
                    ZStack{
                        Image(systemName: "bubble.fill")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding(.trailing,-100)
                            .foregroundStyle(.pancoGreen)
                            .shadow(radius: 5)
                        Text("You currently have no plans!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 180, height: 100)
                            .multilineTextAlignment(.center)
                            .padding(.bottom,40)
                            .padding(.trailing,-100)
                            
                    }
                    
                    // ⭐️ Panco image
                    Image("pancoPNG")
                        .resizable()
                        .scaledToFit()
                        .frame(height:200)
                    
                    // ⭐️ New plan button
                    NavigationLink(destination: PlanningConstraintsView()) {
                        Text("New Plan")
                            .foregroundColor(.pancoNeutral)
                            .font(.headline)
                            .padding()
                            .frame(width: 180, height: 60)
                            .background(.pancoRed)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.top, 50)
                    }
                    
                }
            }//VStack end
        }//ZStack end
    }//body end
}//Struct end

#Preview {
    EmptyPlanView()
}
