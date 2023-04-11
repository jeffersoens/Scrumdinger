//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 11.04.2023.
//

import SwiftUI

struct ThemeView: View {
    
    var theme: Theme
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label("\(theme.name)", systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .buttercup)
    }
}
