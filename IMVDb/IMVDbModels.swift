//
//  MusicVideo.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import Foundation

struct MusicVideo: Codable, Identifiable {
    let id: Int
    
    let song_title: String?
    let year: Int?
    let artists: [Artist]?
    var image: [ImageLink]?
    
    let production_status: String?
    let song_slug: String?
    let url: String?
    let version_name: String?
    let aspect_ratio: String?
    let multiple_versions: Bool?
    let is_imvdb_pick: Bool?
    let verified_credits: Bool?
    let version_number: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        year = try? container.decode(Int.self, forKey: .year)
        song_title = try? container.decode(String.self, forKey: .song_title)
        artists = try? container.decode([Artist].self, forKey: .artists)
        // Handle single ImageLink or array of ImageLink
        image = try? [container.decode(ImageLink.self, forKey: .image)]
        if image == nil {
            image = try? container.decode([ImageLink].self, forKey: .image)
        }
        production_status = try? container.decode(String.self, forKey: .production_status)
        song_slug = try? container.decode(String.self, forKey: .song_slug)
        url = try? container.decode(String.self, forKey: .url)
        version_name = try? container.decode(String.self, forKey: .version_name)
        aspect_ratio = try? container.decode(String.self, forKey: .aspect_ratio)
        multiple_versions = try? container.decode(Bool.self, forKey: .multiple_versions)
        is_imvdb_pick = try? container.decode(Bool.self, forKey: .is_imvdb_pick)
        verified_credits = try? container.decode(Bool.self, forKey: .verified_credits)
        version_number = try? container.decode(Int.self, forKey: .version_number)
    }
    
    init(id: Int, title: String, year: Int, artists: [Artist]) {
        self.id = id
        self.year = year
        song_title = title
        self.artists = artists
        // Handle single ImageLink or array of ImageLink
        image = nil
        production_status = nil
        song_slug = nil
        url = nil
        version_name = nil
        aspect_ratio = nil
        multiple_versions = nil
        is_imvdb_pick = nil
        verified_credits = nil
        version_number = nil
    }
}

struct Artist: Codable, Hashable {    
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
