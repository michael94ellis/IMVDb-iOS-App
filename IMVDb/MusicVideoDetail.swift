//
//  MusicVideoDetail.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/28/20.
//

import SwiftUI

struct MusicVideoDetail: View {
    
    var musicVideo: MusicVideo
    
    var body: some View {
        VStack {
            if let url = URL(string: musicVideo.image?.first?.l ?? "") {
                RemoteImage<Text>(url: url, placeholder: { Text("Loading ...") })
                    .frame(width: 224, height: 126, alignment: .center)
            } else {
                Text("No Image")
                    .frame(width: 224, height: 126, alignment: .center)
            }
            Spacer()
            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Title:")
                    Text("Year:")
                    Text("Artists:")
                    Text("Production Status:")
                }
                VStack(alignment: .trailing, spacing: 10) {
                    Text(musicVideo.song_title ?? "No Title")
                    Text(musicVideo.yearString ?? "0000")
                    Text(musicVideo.artistList)
                    Text(musicVideo.production_status ?? "Unknown")
                }
            }
            Spacer()
        }
    }
}

struct MusicVideoDetail_Previews: PreviewProvider {
    static var previews: some View {
        MusicVideoDetail(musicVideo: MusicVideo(id: 1, title: "TEST SONG NAME", year: 6969, artists: [Artist(name: "SINGER NAME", slug: nil, url: nil, discogs_id: nil)]))
    }
}
