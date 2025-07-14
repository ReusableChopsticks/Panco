import SwiftUI

struct ProfileHistoryView: View {
    
    func dateWeeksAgo(_ weeks: Int) -> Date {
        Calendar.current.date(byAdding: .weekOfYear, value: -weeks, to: Date()) ?? Date()
    }
    var body: some View {
        
        ZStack {
            Color(.pancoNeutral)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button("Back", systemImage: "chevron.backward") {}
                    .foregroundColor(.pancoGreen)
                    .fontWeight(.semibold)
                    .padding(.top, 30)
                    .padding(.leading)
                
                Text("History")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.leading)
                
                ZStack {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            HistoryCardView(
                                date:dateWeeksAgo(0),
                                imageNames: ["Recipe 1", "Recipe 2", "Recipe 3"],
                                counts: [1,3,2]
                            )
                            HistoryCardView(
                                date: dateWeeksAgo(1),
                                imageNames: ["Recipe 4", "Recipe 5"],
                                counts: [1,3,]
                            )
                            
                            HistoryCardView(
                                date: dateWeeksAgo(2),
                                imageNames: ["Recipe 1", "Recipe 5"],
                                counts: [1,3,]
                            )
                        }
                    }
                }
            }
        }
    }
}

struct HistoryCardView: View {
    var date: Date = Date()
    var imageNames: [String]
    var counts: [Int]
    

    var droppedImages: [String] {
        Array(imageNames.dropFirst(3))
    }

    var droppedCounts: [Int] {
        Array(counts.dropFirst(3))
    }
    
    var body: some View {
        
        VStack {
            HStack {
                // Date header
                Text("\(date.formatted(.dateTime.month().day().year()))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("Restore Plan") {}
                    .foregroundColor(Color.pancoNeutral)
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 110, height: 40)
                    .background(Color.pancoGreen)
                    .cornerRadius(30)
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                    .shadow(radius: 2)
                
            }
            // Image row
            VStack{
                HStack {
                    ForEach(imageNames.prefix(3), id: \.self) { image in
                        Image(image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(15)
                            .padding(3)
                    }
                }
                .padding(.top, -5)
                
                HStack {
                    ForEach(imageNames.dropFirst(3), id: \.self) { image in
                        Image(image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(15)
                            .padding(3)
                    }
                }
                .padding(.top, -5)
            }
            
            //recipe x count
            VStack(alignment: .leading) {
                ForEach(Array(zip(imageNames.prefix(5), counts.prefix(5))), id: \.0) { (name, count) in
                    Text("\(name) x \(count)")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.leading, 20)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.pancoLightRed.opacity(0.15))
        .cornerRadius(15)
        .padding(.horizontal, 15)
    }
    
}

#Preview {
    ProfileHistoryView()
}
