import SwiftUI

struct OnboardingDislikeView: View {
    @Binding var isOnboarding: Bool
    let onContinue: () -> Void

    @State private var searchText: String = ""
    @State private var selectedTags: [String] = []

    let allTags: [String] = [
        "Almonds", "Asparagus", "Avocado", "Banana", "Beans", "Beets", "Capsicum",
        "Blue cheese", "Broccoli", "Brussels Sprouts", "Cashews", "Cauliflower", "Celery",
        "Chia seeds", "Chickpeas", "Cilantro (Coriander)", "Coconut", "Cottage Cheese", "Eggplant",
        "Eggs", "Feta Cheese", "Garlic", "Ginger", "Tomatos", "Onions", "Peas", "Peanuts",
        "Pineapple", "Potatoes", "Radishes", "Raspberries", "Spinach", "Strawberries",
        "Sweet Potato", "Tofu", "Turmeric", "Walnuts", "Olives", "Zucchini", "Kale",
        "Mushroom", "Parsley", "Cucumber", "Carrots", "Mayo"
    ].sorted()

    var filteredTags: [String] {
        let matches = allTags.filter {
            searchText.isEmpty || $0.localizedCaseInsensitiveContains(searchText)
        }
        
        let selected = matches.filter { selectedTags.contains($0) }
        let unselected = matches.filter { !selectedTags.contains($0) }
        
        return selected + unselected
    }


    var body: some View {
        ZStack {
            Color(.pancoNeutral)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Title
                Text("Dislikes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 20)

                // Custom Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.pancoGreen)
                    TextField("Search...", text: $searchText)
                        .foregroundColor(.black)
                    Image(systemName: "mic.fill")
                        .foregroundColor(.pancoGreen)
                }
                .padding(10)
                .background(Color.black.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.top, 10)

                // List of Tags
                List {
                    ForEach(filteredTags, id: \.self) { tag in
                        HStack {
                            Text(tag)
                            Spacer()
                            if selectedTags.contains(tag) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.pancoGreen)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedTags.contains(tag) {
                                selectedTags.removeAll { $0 == tag }
                            } else {
                                selectedTags.append(tag)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(.pancoNeutral))
                

                Spacer()

                // Finish Button
                Button("Finish") {
                    isOnboarding = false
                    onContinue()
                }
                .foregroundColor(.pancoNeutral)
                .font(.headline)
                .padding()
                .frame(width: 180, height: 60)
                .background(Color.pancoGreen)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    OnboardingDislikeView(isOnboarding: .constant(true), onContinue: {})
}
