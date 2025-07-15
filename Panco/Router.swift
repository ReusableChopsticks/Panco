//
//  Router.swift
//  Panco
//
//  Created by Erick Hadi on 15/7/2025.
//


//import Foundation
import SwiftUI
import Observation

@Observable class Router {
    var path = NavigationPath()
    
    func popBackHome() {
        path = NavigationPath()
    }
    
    func push(_ route: Route) {
        path.append(route)
    }
}

enum Route: Hashable {
    case planningConstraints
    case planningPortionView(recipeCount: Int)
    
    case anotherScreen(String) // example with associated data
}
