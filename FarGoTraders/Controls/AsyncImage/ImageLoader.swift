//
//  ImageLoader.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import Combine
import UIKit

class ImageLoader: ObservableObject {

  private static let imageProcessingQueue = DispatchQueue(label: "image-processing", qos: .background)

  @Published
  var image: UIImage?

  private(set) var isLoading = false

  private let url: URL
  private var cache: ImageCache?
  private var cancellable: AnyCancellable?

  init (url: URL, cache: ImageCache? = nil) {
    self.url = url
    self.cache = cache
  }

  deinit {
    cancellable?.cancel()
  }

  func load () {
    guard !isLoading else {
      return
    }

    if let image = cache?[url] {
      self.image = image
      return
    }

    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                    receiveOutput: { [weak self] in self?.cache($0) },
                    receiveCompletion: { [weak self] _ in self?.onFinish() },
                    receiveCancel: { [weak self] in self?.onFinish() })
      .subscribe(on: Self.imageProcessingQueue)
      .receive(on: DispatchQueue.main)
      .assign(to: \.image, on: self)
  }

  func cancel () {
    cancellable?.cancel()
  }

  private func onStart () {
    isLoading = true
  }

  private func onFinish () {
    isLoading = false
  }

  private func cache (_ image: UIImage?) {
    image.map { cache?[url] = $0 }
  }
}
