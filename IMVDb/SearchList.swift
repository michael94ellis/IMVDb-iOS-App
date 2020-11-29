//
//  ContentView.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import SwiftUI
import Combine

struct SearchList: View {
    
    @State var queryString: String = ""
    @ObservedObject var imvdb = IMVDb()
    @State private var favoriteColor = 0

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Searchbar(text: $queryString, onTextFieldCommit: {
                    imvdb.makeRequest(for: .Videos, query: queryString.replacingOccurrences(of: " ", with: "+"))
                })
                .padding(.horizontal, 20)
                List(imvdb.musicVideos, id: \.id) { musicVideo in
                    NavigationLink(destination: MusicVideoDetail(musicVideo: musicVideo)) {
                        MusicVideoRow(musicVideo: musicVideo)
                    }
                }
            }
            .navigationBarTitle("Music Videos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchList(queryString: "Mamma Mia", imvdb: IMVDb())
    }
}
