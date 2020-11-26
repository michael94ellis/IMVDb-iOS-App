//
//  MusicVideoRow.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import SwiftUI

struct MusicVideoRow: View {
    
    let musicVideo: MusicVideo
        
    var body: some View {
        HStack {
            RemoteImage<Text>(url: (musicVideo.image?.first?.o) ?? "", placeholder: { Text("Loading ...") })
                .frame(width: 100, height: 100, alignment: .center)
            VStack {
                Text(musicVideo.song_title ?? "No Song Title")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                if let artists = musicVideo.artists {
                    ForEach(artists, id: \.self) { artist in
                        Text(artist.name ?? "No Name")
                    }
                }
            }
        }
        .padding(.horizontal, 20.0)
    }
}


struct MusicVideoRow_Previews: PreviewProvider {
    static var previews: some View {
        MusicVideoRow(musicVideo: MusicVideo(id: 1, title: "SONG TITLE", year: 2020, artists: [Artist(name: "ARTIST NAME", slug: "SLUG", url: nil, discogs_id: nil)]))
    }
}
