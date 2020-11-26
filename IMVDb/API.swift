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

class IMVDb: ObservableObject {
    
    @Published var musicVideos = [MusicVideo]()
    
    private let BaseURL = "https://imvdb.com/api/v1"
    private var searchVideosEndPoint: String { BaseURL + "/search/videos" }
    private var searchEntitiesEndPoint: String { BaseURL + "/search/entities" }
    private let APIKeyHeader = "IMVDB-APP-KEY"
    private let APIKeyValue = "bhmiFPasJ1EeqjLDsMHqsIQ91zk42HCkFNeDSoa1"
    
    enum EndPointType {
        case Videos
        case Entities
    }
    
    /// All searches via the IMVDb API have pagination built in. You can send these parameters with any search to affect the pagination
    enum QueryParameters: String {
        /// Max value is 50.
        case PageSize = "per_page"
        /// The current page number.
        case Page = "page"
    }
    
    enum HTTPError: LocalizedError {
        case statusCode
    }

    var searchRequestNetworkCall: AnyCancellable?
    
    func makeRequest(for endPoint: EndPointType, query: String, params: [QueryParameters: Int] = [:]) {
        guard var urlBuilder = URLComponents(string: self.searchVideosEndPoint) else {
            print("Error: Failed to make URL for \(#function)")
            return
        }
        urlBuilder.queryItems = [URLQueryItem(name: "q", value: query)]
        if !params.isEmpty {
            urlBuilder.queryItems?.append(contentsOf: params.compactMap { URLQueryItem(name: $0.key.rawValue, value: String($0.value))})
        }
        guard let requestURL = urlBuilder.url else {
            print("Error: Failed to make URL for \(#function)")
            return
        }
        var request = URLRequest(url: requestURL)
        request.addValue(self.APIKeyValue, forHTTPHeaderField: self.APIKeyHeader)
        performNetworkCall(with: request)
    }
    
    private func performNetworkCall(with request: URLRequest) {
        searchRequestNetworkCall = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: MusicVideoSearchResults.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print ("Search Completed: \($0)") },
                  receiveValue: { results in
                    print("New Videos: \(results.results?.count ?? 0)")
                    self.musicVideos = results.results?.compactMap { $0 } ?? []
                  })
    }
}
