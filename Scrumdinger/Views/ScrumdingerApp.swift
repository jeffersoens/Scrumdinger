//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 30.03.2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ScrumsView(scrums: $store.scrums) {
                    Task {
                        do {
                            try await store.save(scrums: store.scrums)
                        } catch {
                            print("not saved")
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                    .task {
                        do {
                            try await store.load()
                        } catch {
                            print("not loaded")
                            fatalError(error.localizedDescription)
                        }
                        
                    }
            }
        }
    }
}
