import SwiftUI

struct OnboardingAllergyView: View {
    @State private var selectedTags: Set<String> = []
    let onContinue: () -> Void
    
    let tags = ["Dairy", "Peanut", "Soy", "Egg", "Seafood", "Sulfite", "Gluten", "Tree Nut", "Sesame", "Shellfish", "Wheat", "Latex"]
    
    var body: some View {
        ZStack {
            Color(.pancoNeutral)
                .ignoresSafeArea()
            
            
            VStack(alignment: .leading, spacing: 20) {
                
                //                Button("Back", systemImage: "chevron.backward") {}
                //                    .foregroundColor(Color.pancoGreen)
                //                    .fontWeight(.semibold)
                //                    .padding(.top, 30)
                //                    .padding(.leading)
                
                Text("Allergies")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 40)
                
                ScrollView {
                    Spacer()
                    
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }) {
                            Text(tag)
                                .foregroundColor(selectedTags.contains(tag) ? .white : Color(.pancoGreen))
                                .font(.title3)
                                .fontWeight(.medium)
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
//                .foregroundColor(.white)
//                .font(.headline)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color(.pancoLightGreen))
//                .cornerRadius(20)
//                .shadow(radius: 5)
//                .padding(.horizontal, 100)
//                .padding(.bottom, 30)
            }
        }
    }
}
#Preview {
    OnboardingAllergyView(onContinue: {})
}
