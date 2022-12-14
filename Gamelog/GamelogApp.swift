//
//  GamelogApp.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import SwiftUI

@main
struct GamelogApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "list.dash")
                    }
                
                FavoriteView()
                    .tabItem {
                        Label("Favorite", systemImage: "heart.fill")
                    }
            }
        }
    }
}
