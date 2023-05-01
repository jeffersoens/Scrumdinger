//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 09.04.2023.
//

import SwiftUI

struct ScrumsView: View {
    
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false
    @Environment (\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach($scrums) { $scrum in
                NavigationLink {
                    DetailView(scrum: $scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Your daily scrums")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(
                isPresentingNewScrumView: $isPresentingNewScrumView,
                scrums: $scrums)
        }
        .toolbar {
            Button {
                isPresentingNewScrumView.toggle()
            } label: {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
            }
        }
        
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScrumsView(scrums: .constant(DailyScrum.sampleData),
                       saveAction: {})
        }
    }
}

