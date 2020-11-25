//
//  MusicVideoRow.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import SwiftUI

struct MusicVideoRow: View {
        
    var body: some View {
        
        HStack {
            Image(systemName: "wifi")
                .frame(width: 100, height: 100, alignment: .center)
            VStack {
                Text("Music Video Song Title")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text("Description of some kind")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    
            }
        }
        .padding(.horizontal, 20.0)
    }
}

struct MusicVideoRow_Previews: PreviewProvider {
    static var previews: some View {
        MusicVideoRow()
    }
}
