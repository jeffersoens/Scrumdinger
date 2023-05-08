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
    @State private var errorWrapper: ErrorWarapper?
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                //saveAction()
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWarapper(error: error,
                                                     guidance: "Please try again later")
                    }
                }
            }
            // грузит scrums перед тем, как отобразить View
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWarapper(error: error,
                                                 guidance: "Scrumdinger will load sample data and continue.")
                }
                
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.scrums = DailyScrum.sampleData
            }, content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            })
        }
    }
}
