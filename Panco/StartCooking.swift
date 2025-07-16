import SwiftUI

struct StartCooking: View {
    @Environment(\.dismiss) var dismiss  // For back button
    @State private var step = 1

    @Binding var rootIsActive : Bool
    
    let steps = [
        "Start by mincing the garlic",
        "Chop the onions finely",
        "Heat the pan and add oil",
        "Sauté the garlic and onions",
        "Add the chicken and cook until golden"
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.pancoNeutral
                    .ignoresSafeArea()

                VStack {
                    // Custom Back Button
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.pancoGreen)
                            Text("Back")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.pancoGreen)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    Spacer()

                    // Card Content
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Step \(step)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.pancoRed)

                        Text(steps[step - 1])
                            .font(.largeTitle)
                            .fixedSize(horizontal: false, vertical: true)

                        Spacer()

                        // Navigation Arrows
                        HStack {
                            Button(action: {
                                if step > 1 { step -= 1 }
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(step > 1 ? .pancoNeutral : .pancoRed)
                                    .frame(width: 60, height: 60)
                                    .background(Color.pancoRed.opacity(0.8))
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }
                            .disabled(step == 1)

                            Spacer()

                            Button(action: {
                                if step < steps.count {
                                    step += 1
                                } else {
                                    step = 1
                                }
                            }) {
                                Image(systemName: step == steps.count ? "checkmark" : "chevron.right")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.pancoNeutral)
                                    .frame(width: 60, height: 60)
                                    .background(Color.pancoRed.opacity(0.8))
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }
                        }
                        .padding(.bottom, 60)
                    }
                    .padding()
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .padding(.horizontal, 30)

                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        StartCooking(rootIsActive: .constant(true))
    }
}
