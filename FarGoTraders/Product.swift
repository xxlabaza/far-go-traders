//
//  Product.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import Foundation

struct Product: Equatable, Hashable, Codable, Identifiable {

  private static let defaultImage = URL(string: "https://static.wikia.nocookie.net/fallout/images/9/92/Fo1_brass_knuckles2.png")

  static func formatDecimalString (for price: Int) -> String {
    if price == 0 {
      return "$0.00"
    }
    let left = price / 100
    let right = price % 100
    return String(format: "$%d.%02d", left, right)
  }

  let id: String
  let title: String
  let picture: URL
  let price: Int

  var decimalPriceString: String {
    Product.formatDecimalString(for: price)
  }
}
