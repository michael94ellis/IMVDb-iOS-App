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
            if let url = URL(string: musicVideo.image?.first?.l ?? "") {
                RemoteImage<Text>(url: url, placeholder: { Text("Loading ...") })
                    .frame(width: 112, height: 63, alignment: .center)
            } else {
                Text("No Image")
                    .frame(width: 75, height: 120, alignment: .center)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(makeMusicVideoRowTitle(for: musicVideo))
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                }
                Text(musicVideo.artistList)
            }
        }
    }
    
    func makeMusicVideoRowTitle(for musicVideo: MusicVideo) -> String {
        var titleString = musicVideo.song_title ?? "No Song Title"
        if let year = musicVideo.yearString {
            titleString += " (\(year))"
        }
        return titleString
    }
}


struct MusicVideoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MusicVideoRow(musicVideo: MusicVideo(id: 1, title: "SONG TITLE", year: 2020, artists: [Artist(name: "ARTIST NAME", slug: "SLUG", url: nil, discogs_id: nil)]))
            MusicVideoRow(musicVideo: MusicVideo(id: 1, title: "SONG TITLE", year: 2020, artists: [Artist(name: "ARTIST NAME", slug: "SLUG", url: nil, discogs_id: nil)]))
        }
    }
}
