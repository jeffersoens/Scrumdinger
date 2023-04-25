//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 10.04.2023.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    
    
    var body: some View {
        Form {
            Section("Meeting Info") {
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Meeting Lenght")
                    }
                    .accessibilityLabel("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .frame(width: 100, alignment: .trailing)
                        .accessibilityHidden(true)
                }
                ThemePickerView(selection: $data.theme)
            }
            Section("Attendees") {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button {
                        withAnimation {
                            let newAttendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(newAttendee)
                            newAttendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add new attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
