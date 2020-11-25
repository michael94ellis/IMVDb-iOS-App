//
//  API.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import Foundation
import Combine

/// This object contains API Information for accessing IMVDb
///
/// The endpoint for getting a single video's data looks like this:
/// https://imvdb.com/api/v1/video/{video-id}
///
/// More data can be retrieved about a single video or entity like this:
/// https://imvdb.com/api/v1/video/121779770452?include=credits,bts,countries
/// Additional Info Categories Include:
///     - sources
///     - credits
///     - featured
///     - popularity
///     - bts (behind the scenes)
///     - countries
///
///
/// An entity is anything with a name in the IMVDb Database (artists, companies, people, etc)
/// The endpoint for getting data about entities looks like this:
/// https://imvdb.com/api/v1/entity/{entity-id}
/// Additional Info Categories Include:
///     - credits
///     - credit_summary
///     - artist_videos
///     - featured_videos
///

struct IMVDb {
    
    static var shared = IMVDb()
    
    let BaseURL = "https://imvdb.com/api/v1"
    let APIKeyHeader = "IMVDB-APP-KEY"
    let APIKeyValue = "bhmiFPasJ1EeqjLDsMHqsIQ91zk42HCkFNeDSoa1"
    
    enum EndPoint {
        case Videos
        case Entities
    }
    var searchVideosEndPoint: String { BaseURL + "/search/videos" }
    var searchEntitiesEndPoint: String { BaseURL + "/search/entities" }
    /// All searches via the IMVDb API have pagination built in. You can send these parameters with any search to affect the pagination
    struct Parameters {
        /// Max value is 50.
        static let PageSize = "per_page"
        /// The current page number.
        static let Page = "page"
    }
    
    enum HTTPError: LocalizedError {
        case statusCode
    }

    var cancellable: AnyCancellable?
    
    mutating func makeRequest(for endPoint: EndPoint) {
        
        let url = URL(string: self.searchVideosEndPoint + "?q=mamma+mia+abba")!
        var request = URLRequest(url: url)
        request.addValue(self.APIKeyValue, forHTTPHeaderField: self.APIKeyHeader)
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: MusicVideoSearchResults.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print ("Search Completed: \($0)") },
                  receiveValue: { results in
                    print ("Received Movie Search Results: \n")
                    results.results?.forEach { print($0.song_title!) }
                  })
    }
}
