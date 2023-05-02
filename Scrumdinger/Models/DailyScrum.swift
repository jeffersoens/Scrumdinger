//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 02.04.2023.
//

import Foundation

struct DailyScrum: Identifiable, Codable {
    var id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Double
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Double, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    
    struct Attendee: Identifiable, Codable {
        var id: UUID
        let name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
//    struct Data {
//        var title: String = ""
//        var attendees: [Attendee] = []
//        var lengthInMinutes: Double = 5
//        var theme: Theme = .seafoam
//    }
//    
//    var data: Data {
//        Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
//    }
//    
//    mutating func update(from data: Data) {
//        title = data.title
//        attendees = data.attendees
//        lengthInMinutes = Int(data.lengthInMinutes)
//        theme = data.theme
//    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: Theme.allCases.randomElement() ?? .sky)
    }
}

extension DailyScrum {
    static var sampleData =
    [
        DailyScrum(
            title: "Design",
            attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
            lengthInMinutes: 10,
            theme: .yellow),
        DailyScrum(
            title: "App Dev",
            attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
            lengthInMinutes: 5,
            theme: .orange),
        DailyScrum(
            title: "Web Dev",
            attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
            lengthInMinutes: 5,
            theme: .poppy)
    ]
}
