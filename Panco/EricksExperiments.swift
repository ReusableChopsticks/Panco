//
//  EricksExperiments.swift
//  Panco
//
//  Created by Erick Hadi on 14/7/2025.
//

import SwiftUI

struct TaylorSwiftResultsList: View {
    @State private var results = [Result]()
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        Button("Fetch recipe") {
//            Task {
//                await fetchRecipe()
//            }
//        }
        VStack {
            AsyncImage(url: URL(string: "https://img.spoonacular.com/recipes/716429-312x231.jpg"))
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }.task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    var results: [Result]
}

class SpoonacularParams: Codable {
    
}

#Preview {
    TaylorSwiftResultsList()
}
