//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 30.03.2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @State private var scrums = DailyScrum.sampleData
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
