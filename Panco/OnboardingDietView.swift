//OnboardingDietView - 1st page the user will see when they first open the app.
// created by Avia
// last edited Monday 14th July 9:39pm


import SwiftUI

struct OnboardingDietView: View {
    @State private var selectedTags: Set<String> = []
    let onContinue: () -> Void
    
    let tags = ["Vegan", "Vegetarian", "Pescetarian", "Keto", "Halal", "Kosher"]
    
    var body: some View {
        ZStack {
            Color(.pancoNeutral)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Diet")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 40)
                    .padding(.top, 50)
                
                ScrollView {
                    Spacer()
                    
                    //‼️ need to remember tags to put into preferences so that the user can change it as well as to recommend recipes that fit their dietary requirements
                    
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }) {
                            Text(tag)
                                .foregroundColor(selectedTags.contains(tag) ? .white : Color(red: 0.21, green: 0.55, blue: 0.39))
                                .font(.title3)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(selectedTags.contains(tag) ? Color.pancoGreen : Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.pancoGreen, lineWidth: 5)
                                )
                                .cornerRadius(15)
                        }
                        .padding(.horizontal, 30)
                    }
                }
                
                Spacer()
                
//                Button("Continue") {
//                    onContinue()
//                }
//                    .foregroundColor(.white)
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color(red: 0.52, green: 0.62, blue: 0.56))
//                    .cornerRadius(20)
//                    .shadow(radius: 5)
//                    .padding(.horizontal, 100)
//                    .padding(.bottom, 30)
            }
        }
    }
}
#Preview {
    OnboardingDietView(onContinue: {})
}

