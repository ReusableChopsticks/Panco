// ✏️: code pending ; ‼️: code error

// Version: 14 July 1.40PM
// By Nikki

import SwiftUI

struct EmptyPlanView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                //Background color
                Rectangle()
                    .fill(.pancoNeutral)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
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
//                    NavigationLink(destination: PlanningConstraintsView()) {
                    
                    Button(action: {}, label: {
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
                           
                    )
                }
            }//VStack end
            .navigationTitle(Text("Plans"))
        }//ZStack end
    }//body end
}//Struct end

#Preview {
    EmptyPlanView()
}
