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
        NavigationStack {
            List {
                ForEach($scrums) { $scrum in
                    NavigationLink {
                        DetailView(scrum: $scrum)
                    } label: {
                        CardView(scrum: scrum)
                    }
                    .listRowBackground(scrum.theme.mainColor)
                }
                .onDelete { indices in
                    scrums.remove(atOffsets: indices)
                }
            }
            .navigationTitle("Your daily scrums")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isPresentingNewScrumView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(
                isPresentingNewScrumView: $isPresentingNewScrumView,
                scrums: $scrums)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive || phase == .background {
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

