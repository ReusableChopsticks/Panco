import SwiftUI

struct FavouritesView: View {
    
    @State private var searchBar: String = ""
    
    let recipeImages = ["Recipe 1", "Recipe 2", "Recipe 3", "Recipe 4", "Recipe 5"]
    
    let columns = [
        GridItem(.fixed(150), spacing: 40),
        GridItem(.fixed(150), spacing: 40)
    ]
    
    var filteredImages: [String] {
        if searchBar.isEmpty {
            return recipeImages
        } else {
            return recipeImages.filter { $0.localizedCaseInsensitiveContains(searchBar) }
        }
    }
    
    var body: some View {
        ZStack {
            // Background color
            Color(.pancoNeutral)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Text("Favourites")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.leading)
                    .padding(.top, 30)
                
                //search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.pancoGreen)
                        .fontWeight(.bold)
                    TextField("Search...", text: $searchBar)
                        .foregroundColor(.black)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    Spacer()

                        Image(systemName: "mic.fill")
                        .foregroundColor(.pancoGreen)

                }
                .padding(10)
                .background(Color.black.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 4) {
                        ForEach(filteredImages, id: \.self) { imageName in
                            ZStack(alignment: .bottomLeading) {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 170, height: 170)
                                    .cornerRadius(20)
                                    .padding(10)
                                
                                // Dark overlay
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black.opacity(0.4))
                                    .frame(width: 170, height: 170)
                                    .padding(10)
                                
                                // Title
                                Text("\(imageName)")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(6)
                                    .padding(.leading, 15)
                                    .padding(.bottom, 10)
                                
                                // Heart icon (top right)
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.red)
                                    .padding(8)
                                     .position(x: 155, y: 35)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FavouritesView().environment(RecipeManager())
}
