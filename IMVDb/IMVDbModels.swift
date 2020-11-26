//
//  MusicVideo.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import Foundation

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
    let image: ImageLinkArrayOrObject?
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

extension MusicVideo {
    /// This enables an inconsistent backend to send either single objects or arrays of an object
    enum ImageLinkArrayOrObject: Codable {
        case array([ImageLink])
        case single(ImageLink)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                self = try .array(container.decode([ImageLink].self))
            } catch DecodingError.typeMismatch {
                do {
                    self = try .single(container.decode(ImageLink.self))
                } catch DecodingError.typeMismatch {
                    throw DecodingError.typeMismatch(ImageLinkArrayOrObject.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
                }
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .array(let array):
                try container.encode(array)
            case .single(let single):
                try container.encode(single)
            }
        }
    }
}
