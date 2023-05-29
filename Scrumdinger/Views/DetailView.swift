//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 09.04.2023.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var scrum: DailyScrum
    
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section("Meeting info") {
                NavigationLink {
                    MeetingView(scrum: $scrum)
                        .navigationTitle("\(scrum.title) meeting")
                } label: {
                    Label("Start meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Lenght", systemImage: "clock")
                    Spacer()
                    Text("\(Int(scrum.lengthInMinutes)) minutes")
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
            
            Section("History") {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                
                ForEach(scrum.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
            
        }
        .navigationTitle(scrum.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                editingScrum = scrum
                isPresentingEditView.toggle()
            } label: {
                Text("Edit")
            }
            
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(isNewScrum: false, data: $editingScrum)
                    .navigationTitle(editingScrum.title)
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
                                scrum = editingScrum
                            } label: {
                                Text("Save")
                            }
                        }
                    }
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
