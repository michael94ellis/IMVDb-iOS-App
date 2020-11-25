//
//  MusicVideo.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import Foundation

//["song_slug": mamma-mia,
// "artists": <__NSSingleObjectArrayI 0x600002fd0100>(
//        {
//            name = Abba;
//            slug = abba;
//            url = "https://imvdb.com/n/abba";
//        }
//    )
//, "id": 938884056168,
//  "version_number": 1,
//  "image": {
//        b = "https://s3.amazonaws.com/images.imvdb.com/video/938884056168-abba-mamma-mia_music_video_bv.jpg";
//        l = "https://s3.amazonaws.com/images.imvdb.com/video/938884056168-abba-mamma-mia_music_video_lv.jpg";
//        o = "https://s3.amazonaws.com/images.imvdb.com/video/938884056168-abba-mamma-mia_music_video_ov.jpg";
//        s = "https://s3.amazonaws.com/images.imvdb.com/video/938884056168-abba-mamma-mia_music_video_sv.jpg";
//        t = "https://s3.amazonaws.com/images.imvdb.com/video/938884056168-abba-mamma-mia_music_video_tv.jpg";
//  }   ,
//  "song_title": Mamma Mia,
//  "multiple_versions": 0,
//  "production_status": r,
//  "year": 1975,
//  "aspect_ratio": <null>,
//  "url": https://imvdb.com/video/abba/mamma-mia,
//  "version_name": <null>,
//  "is_imvdb_pick": 0,
//  "verified_credits": 0

struct MusicVideo: Codable {
    let id: Int
    let production_status: String?
    let song_title: String?
    let song_slug: String?
    let url: String?
    let multiple_versions: Bool?
    let version_name: String?
    let version_number: Int?
    let is_imvdb_pick: Bool?
    let aspect_ratio: String?
    let year: Int?
    let verified_credits: Bool?
    let artists: [Artist]?
    let image: ImageLink?
}

struct Artist: Codable {
    let name: String?
    let slug: String?
    let url: String?
    let discogs_id: Int?
}

/// Images associated with a Video or Entity, URLs
struct ImageLink: Codable {
    /// This is the raw, largest image we can find for the source and can be one of many sizes
    let o: String?
    /// 224x126
    let l: String?
    /// 125x70
    let b: String?
    /// 50x80
    let t: String?
    /// No idea what size this is
    let s: String?
}

struct MusicVideoSearchResults: Codable {
    let total_results: Int?
    let current_page: Int?
    let per_page: Int?
    let total_pages: Int?
    let results: [MusicVideo]?
}
