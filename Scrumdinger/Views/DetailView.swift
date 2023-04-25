//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 09.04.2023.
//

import SwiftUI

struct DetailView: View {
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    @Binding var scrum: DailyScrum
    
    var body: some View {
        List {
             Section("Meeting Info") {
                 NavigationLink {
                     MeetingView(scrum: $scrum)
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
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                isPresentingEditView.toggle()
                            } label: {
                                Text("Cancel")
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                isPresentingEditView.toggle()
                                scrum.update(from: data)
                            } label: {
                                Text("Save")
                            }
                        }
                    }
            }
        }
        .toolbar {
            Button {
                isPresentingEditView.toggle()
                data = scrum.data
            } label: {
                Text("Edit")
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
