//
//  ContentView.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        Button("Hello, world!") {
            IMVDb.shared.makeRequest(for: .Videos)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
