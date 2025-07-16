import SwiftUI

struct OnboardingDislikeView: View {
    @State private var searchBar: String = ""
    @State private var selectedTags: [String] = []
    @Binding var isOnboarding: Bool
    let onContinue: () -> Void
    
    // Simulated tag database
    let allTags: [String] = ["Almonds", "Asparagus", "Avocado", "Banana", "Beans", "Beets", "Capsicum", "Blue cheese", "Broccoli", "Brussels Sprouts", "Cashews", "Cauliflower", "Celery", "Chia seeds", "Chickpeas", "Cilantro (Coriander)", "Coconut", "Cottage Cheese", "Eggplant", "Eggs", "Feta Cheese", "Garlic", "Ginger", "Tomatos", "Onions", "Peas", "Peanuts", "Pineapple", "Potatoes", "Radishes", "Raspberries", "Spinach", "Strawberries", "Sweet Potato", "Tofu", "Turmeric", "Walnuts", "Olives", "Zucchini", "Kale", "Mushroom", "Parsley", "Cucumber", "Carrots", "Mayo"]
    
    // Filtered results based on search input
    var filteredTags: [String] {
        if searchBar.isEmpty {
            return allTags
        } else {
            return allTags.filter { $0.localizedCaseInsensitiveContains(searchBar) }
        }
    }
    
    
    var sortedFilteredTags: [String] {
        let selected = filteredTags.filter { selectedTags.contains($0) }
        let unselected = filteredTags.filter { !selectedTags.contains($0) }
        return selected + unselected
    }
    
    
    var body: some View {
        
        
        GeometryReader { geometry in
            ZStack {
                Color(.pancoNeutral)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Dislikes")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(.leading)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.4))
                            TextField("Search...", text: $searchBar)
                                .foregroundColor(.black)
                                .textFieldStyle(PlainTextFieldStyle())
                            Spacer()
                            Image(systemName: "mic.fill")
                                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.4))
                        }
                        .padding(10)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                    ScrollView  {
                            generateContent(in: geometry)
                            .padding(.leading ,10)
                        }
                      
                        
                        
                    }
                    Spacer()
                    
                    Button("Finish") {
                        isOnboarding = false
                    }
                        .foregroundColor(.pancoNeutral)
                        .font(.headline)
                        .padding()
                        .frame(width: 180, height: 60)
                        .background(.pancoGreen)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding(.horizontal, 100)
                        .padding(.bottom, 30)
           
                }
            }
            
        }
    }
    
    //tag (too complicated idk what is going on too)
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.sortedFilteredTags, id: \.self) { platform in
                self.item(for: platform)
                    .padding([.horizontal, .vertical], 5)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.filteredTags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if platform == self.filteredTags.last! {
                            height = 0
                            
                        }
                        return result
                    })
            }
        }
    }
    
    //‼️ selected tag
    func item(for text: String) -> some View {
        let isSelected = selectedTags.contains(text)

        return Text(text)
            .foregroundColor(isSelected ? Color(.pancoNeutral) : Color(.pancoGreen))
            .font(.title3)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .frame(alignment: .leading)
            .background(isSelected ? Color(.pancoGreen) : Color.clear)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color(.pancoGreen), lineWidth: 2)
            )
            .onTapGesture {
                if isSelected {
                    selectedTags.removeAll(where: { $0 == text })
                } else {
                    selectedTags.append(text)
                }
            }
    }

}

#Preview {
    OnboardingDislikeView(isOnboarding: .constant(true), onContinue: {})
}
