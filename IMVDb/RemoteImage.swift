//
//  RemoteImage.swift
//  IMVDb
//
//  Created by Michael Ellis on 11/25/20.
//

import SwiftUI
import Combine

struct RemoteImage<Placeholder: View>: View {
    @StateObject private var loader: ImageDownloader
    private let placeholder: Placeholder
    
    init(url: String, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageDownloader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

//struct RemoteImage_Previews: PreviewProvider {
//    static var previews: some View {
////        RemoteImage(downloader: "https://cf.geekdo-images.com/thumb/img/sD_qvrzIbvfobJj0ZDAaq-TnQPs=/fit-in/200x150/pic2649952.jpg")
//    }
//}
