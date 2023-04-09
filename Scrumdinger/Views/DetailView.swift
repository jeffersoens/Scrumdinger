//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 09.04.2023.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        List {
             Section("Meeting Info") {
                 NavigationLink {
                     MeetingView()
                 } label: {
                     Label("Start Meeting", systemImage: "timer")
                         .font(.headline)
                         .foregroundColor(.accentColor)
                 }
                HStack {
                    Label("Lenght", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                 HStack {
                     Label("Theme", systemImage: "paintpalette")
                     Spacer()
                     Text("\(scrum.theme.name)")
                         .padding(7)
                         .foregroundColor(scrum.theme.accentColor)
                         .background(scrum.theme.mainColor)
                         .cornerRadius(4)
                 }
            }
            Section("Attendees") {
                ForEach(scrum.attendees) { attendee in
                    Label("\(attendee.name)", systemImage: "person")
                }
            }
        }
        .navigationTitle("Design")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}
