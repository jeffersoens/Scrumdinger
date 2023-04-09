//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 09.04.2023.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink {
                    DetailView(scrum: scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
        }
        .toolbar {
            Button {
                //
            } label: {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}

