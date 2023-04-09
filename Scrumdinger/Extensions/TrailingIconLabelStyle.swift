//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 08.04.2023.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self {
        Self()
    }
}

