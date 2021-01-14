//
//  Product+init.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import Foundation

extension Product {

  private static let defaultImage = URL(string: "https://static.wikia.nocookie.net/fallout/images/9/92/Fo1_brass_knuckles2.png")

  init (sku: String, dto: ProductDto) {
    self.id = sku
    self.title = dto.title
    self.picture = dto.picture ?? Product.defaultImage!
    self.price = dto.price
  }
}
