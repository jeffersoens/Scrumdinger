//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 10.04.2023.
//

import SwiftUI

struct DetailEditView: View {
    
    enum Field: Hashable {
        case attendee
    }
    
    let isNewScrum: Bool
    @Binding var data: DailyScrum
    @State private var newAttendeeName = ""
    @FocusState private var isFocused: Bool
    @FocusState private var focusedField: Field?
    
    var body: some View {
        Form {
            Section("\(data.title) info") {
                TextField("Title", text: $data.title)
                    .focused($isFocused)
                    .submitLabel(isNewScrum ? .continue : .done)
                    .onSubmit {
                        if isNewScrum {
                            focusedField = .attendee
                        }
                    }
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
                        .focused($focusedField, equals: .attendee)
                        .submitLabel(isNewScrum ? .continue : .done)
                        .onSubmit {
                            if isNewScrum {
                                withAnimation {
                                    let newAttendee = DailyScrum.Attendee(name: newAttendeeName)
                                    data.attendees.append(newAttendee)
                                    newAttendeeName = ""
                                }
                                focusedField = .attendee
                            }
                        }
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
        .onAppear {
            isFocused = isNewScrum
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(
            isNewScrum: true,
            data: .constant(DailyScrum.sampleData[0])
        )
    }
}
