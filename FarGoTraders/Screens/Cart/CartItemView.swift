//
//  CartItemView.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import SwiftUI

struct CartItemView: View {

  @EnvironmentObject
  var userData: UserData

  @Environment(\.imageCache)
  var cache: ImageCache

  let product: Product

  var body: some View {
    HStack {
      productInfo
      Spacer()
      productImage
    }
  }

  private var productInfo: some View {
    let count = userData.selectedProducts[product] ?? 0
    return VStack(alignment: .leading, spacing: 10) {
      Text(product.title)

      Text(product.decimalPriceString)

      HStack {
        Button(action: { self.decrease() }) {
          Image(systemName: "minus.circle.fill").imageScale(.large)
        }
        .buttonStyle(BorderlessButtonStyle())
        .disabled(count <= 0)
        .accentColor(.red)

        Text("\(count)").frame(width: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

        Button(action: { self.increase() }) {
          Image(systemName: "plus.circle.fill").imageScale(.large)
        }
        .buttonStyle(BorderlessButtonStyle())
        .disabled(count >= 99)
        .accentColor(.green)
      }
    }
  }

  private var productImage: some View {
    AsyncImage(
      url: product.picture,
      cache: cache,
      placeholder: spinner,
      configuration: { $0.resizable().renderingMode(.original) }
    )
    .aspectRatio(contentMode: .fit)
    .frame(idealHeight: 35)
  }

  private var spinner: some View {
    Spinner(isAnimating: true, style: .medium)
  }

  private func decrease () {
    let oldCount = userData.selectedProducts[product] ?? 0
    if oldCount <= 1 {
      userData.selectedProducts[product] = 0
    } else {
      userData.selectedProducts[product] = oldCount - 1
    }
  }

  private func increase () {
    let oldCount = userData.selectedProducts[product] ?? 0
    if oldCount >= 99 {
      userData.selectedProducts[product] = 99
    } else {
      userData.selectedProducts[product] = oldCount + 1
    }
  }
}

#if DEBUG
struct CartItemView_Previews: PreviewProvider {

  private static let defaultProduct = Product(
    id: "1",
    title: "Brass knuckles",
    picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/9/92/Fo1_brass_knuckles.png")!,
    price: 220000
  )

  static var previews: some View {
    let userData = UserData()
    userData.selectedProducts[defaultProduct] = 0
    return CartItemView(product: defaultProduct)
      .environmentObject(userData)
      .previewLayout(PreviewLayout.sizeThatFits)
      .padding()
  }
}
#endif
