//
//  ProductsApi.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import Foundation
import Combine

enum ProductsApi {

  static let baseImage = URL(string: "https://static.wikia.nocookie.net/fallout/images")!
  static let baseApi = URL(string: "https://xxlabaza-products-default-rtdb.europe-west1.firebasedatabase.app")!

  fileprivate static let agent = Agent()

  static func getAllProducts () -> AnyPublisher<[String: ProductDto], Error> {
    let request = URLComponents(
      url: baseApi.appendingPathComponent("/products.json"),
      resolvingAgainstBaseURL: true
    )?
    .url
    .map { URLRequest.init(url: $0) }

    return agent.run(request!)
      .map(\.value)
      .eraseToAnyPublisher()
  }
}

struct ProductDto: Codable {

  let title: String
  let picture_path: String?
  let price: Int

  var picture: URL? { picture_path.map { ProductsApi.baseImage.appendingPathComponent($0) } }
}

fileprivate struct Agent {

  struct Response<T> {

    let value: T
    let response: URLResponse
  }

  func run<T: Decodable> (_ request: URLRequest,
                          _ decoder: JSONDecoder = JSONDecoder()
  ) -> AnyPublisher<Response<T>, Error> {
    return URLSession.shared
      .dataTaskPublisher(for: request)
      .tryMap { result -> Response<T> in
        let value = try decoder.decode(T.self, from: result.data)
        return Response(value: value, response: result.response)
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
