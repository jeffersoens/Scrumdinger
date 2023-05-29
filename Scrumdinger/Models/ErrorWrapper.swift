//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 08.05.2023.
//

import Foundation

struct ErrorWarapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}


