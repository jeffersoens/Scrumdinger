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
            HStack {
                Circle()
                    .foregroundColor(theme.mainColor)
                Text("\(theme.name)")
            }
            .padding([.trailing])
            .fixedSize()
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .indigo)
    }
}
