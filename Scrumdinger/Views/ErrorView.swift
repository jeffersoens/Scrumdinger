//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 08.05.2023.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWarapper
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("An error has occured!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }

                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWarapper {
        ErrorWarapper(error: SampleError.errorRequired,
                      guidance: "This is an example error")
    }
    
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
