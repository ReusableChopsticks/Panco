// EmptyPlanView: Display user's empty meal plan
// Created by: Nikki on 14 July
// Last edited by: Nikki on 14 July 9.30PM (Sent)

import SwiftUI

struct EmptyPlanView: View {
    
    @State var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                //Background color
                Color(.pancoNeutral)
                            .ignoresSafeArea()
                
                VStack{
                    HStack {
                        Text("Plan")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        Spacer()
                    }
                    .padding(.horizontal,20)
                    
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
                    .padding(.trailing, 30)
                    
                    // ⭐️ Panco image
                    Image("pancoPNG")
                        .resizable()
                        .scaledToFit()
                        .frame(height:200)
                    
                    NavigationLink (destination: PlanningConstraintsView(rootIsActive: $isActive), isActive: $isActive) {
                        Text("New Plan")
                            .foregroundColor(.pancoNeutral)
                            .font(.headline)
                            .padding()
                            .frame(width: 180, height: 60)
                            .background(Color.pancoRed)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
                    }
                    .padding(.top, 105 )
                    
                    
                    
                }
            }//VStack end
        }//ZStack end
    }//body end
}//Struct end

#Preview {
    EmptyPlanView().environment(RecipeManager())
}
