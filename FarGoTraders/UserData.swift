//
//  UserData.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import Combine
import Foundation

final class UserData: ObservableObject {

  let objectWillChange = PassthroughSubject<UserData, Never>()

  @Storage(key: "SelectedProducts", defaultValue: [:])
  var selectedProducts: [Product: Int] {
    didSet {
      objectWillChange.send(self)
    }
  }
}

@propertyWrapper
struct Storage<T: Codable> {

  let key: String
  let defaultValue: T

  var wrappedValue: T {
    get {
      guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
        return defaultValue
      }
      let value = try? JSONDecoder().decode(T.self, from: data)
      return value ?? defaultValue
    }
    set {
      let data = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(data, forKey: key)
    }
  }
}
