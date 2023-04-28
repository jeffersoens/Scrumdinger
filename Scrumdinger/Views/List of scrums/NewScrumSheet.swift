//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 27.04.2023.
//

import SwiftUI

struct NewScrumSheet: View {
    
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var isPresentingNewScrumView: Bool
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            DetailEditView(data: $newScrum)
                .navigationTitle(newScrum.title)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            scrums.append(newScrum)
                            isPresentingNewScrumView.toggle()
                        } label: {
                            Text("Add")
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            isPresentingNewScrumView.toggle()
                        } label: {
                            Text("Dismiss")
                        }
                        
                    }
                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(
            isPresentingNewScrumView: .constant(true),
            scrums: .constant(DailyScrum.sampleData))
    }
}
