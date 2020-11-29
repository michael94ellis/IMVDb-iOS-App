//
//  ImageDownloader.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/26/20.
//

import Foundation
import Combine
import SwiftUI

class ImageDownloader: ObservableObject {
    
    private(set) var isLoading = false
    private var cache: ImageCache?
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    private static let downloadQueue = DispatchQueue(label: "image-downloader")

    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    func load() {
        guard !isLoading else {
            print("Warning: \(self) is already loading an image")
            return
        }
        if let image = cache?[url] {
            self.image = image
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.downloadQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        cancel()
    }
}
