//
//  ImageDownloader.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/26/20.
//

import Foundation
import Combine
import UIKit

class ImageDownloader: ObservableObject {
    
    @Published var image: UIImage?
    private let url: URL?
    private var cancellable: AnyCancellable?
    
    init(url: String) {
        if let urlFromString = URL(string: url) {
            self.url = urlFromString
        } else {
            self.url = nil
        }
    }
    
    func load() {
        guard let url = url else {
            print("Error: Cannot download image, nil URL found")
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        cancel()
    }
}
