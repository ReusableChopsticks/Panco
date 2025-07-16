//
//  OnboardingRootView.swift
//  Panco
//
//  Created by Erick Hadi on 16/7/2025.
//

import SwiftUI

struct OnboardingRootView: View {
    @State private var currentPage = 0
    @Binding var isOnboarding: Bool
    
    init(isOnboarding: Binding<Bool>) {
        self._isOnboarding = isOnboarding
        
        // Change page control colors
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    var body: some View {
        ZStack {
            Color(.pancoNeutral).ignoresSafeArea()
            
            TabView(selection: $currentPage) {
                OnboardingDietView(
                    onContinue: { currentPage += 1 }
                )
                .tag(0)
                
                OnboardingAllergyView(
                    onContinue: { currentPage += 1 }
                )
                .tag(1)
                
                OnboardingDislikeView(
                    isOnboarding: $isOnboarding,
                    onContinue: { print("Done!") },
                )
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
    }
}

#Preview {
    OnboardingRootView(isOnboarding: .constant(true))
}
