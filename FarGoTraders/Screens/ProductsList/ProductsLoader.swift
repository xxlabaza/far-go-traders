//
//  ProductsLoader.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import Combine
import Foundation

final class ProductsLoader: ObservableObject {

  @Published
  var products: [Product]?

  private(set) var isLoading = false
  private var cancellable: AnyCancellable?

  func load () {
    guard !isLoading else {
      return
    }

    cancellable = ProductsApi.getAllProducts()
      .map { data in data.map { (sku, dto) in Product(sku: sku, dto: dto) } }
      .map { products in products.sorted(by: { $0.id < $1.id } ) }
      .replaceError(with: nil)
      .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                    receiveCompletion: { [weak self] _ in self?.onFinish() },
                    receiveCancel: { [weak self] in self?.onFinish() })
      .subscribe(on: DispatchQueue.main)
      .receive(on: DispatchQueue.main)
      .assign(to: \.products, on: self)
  }

  func cancel () {
    cancellable?.cancel()
  }

  private func onStart() {
    isLoading = true
  }

  private func onFinish() {
    isLoading = false
  }
}
