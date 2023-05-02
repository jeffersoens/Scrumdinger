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
            ScrumsView(scrums: $store.scrums) {
                //saveAction()
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            // грузит scrums перед тем, как отобразить View
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
                
            }
        }
    }
}
