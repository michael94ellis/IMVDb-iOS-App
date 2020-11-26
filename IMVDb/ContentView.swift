//
//  ContentView.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var queryString: String = "Mamma Mia"
    @ObservedObject var imvdb = IMVDb()

    var body: some View {
        VStack {
            Text("IMVDb Search")
                .font(.largeTitle)
            HStack {
                Text("Search: ")
                TextField("Query", text: $queryString)
                    .padding(.leading, 10.0)
            }
            .padding(.all, 30.0)
            Button(action: {
                imvdb.makeRequest(for: .Videos, query: queryString.replacingOccurrences(of: " ", with: "+"))
            }) {
                Text("Search")
                    .frame(width: 110, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(20)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Spacer()
            
            List(imvdb.musicVideos, id: \.id) { musicVideo in
                MusicVideoRow(musicVideo: musicVideo)
            }
        }
        .padding(.top, 75)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
