//
//  ProductItemView.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import SwiftUI

struct ProductItemView: View {

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
    VStack(alignment: .leading, spacing: 10) {
      Text(product.title)

      HStack {
        Button(action: { addToCart() }) {
          Text("Add")
            .bold()
            .font(.body)
            .padding(4)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .buttonStyle(BorderlessButtonStyle())

        Text(product.decimalPriceString)
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

  private func addToCart () {
    let oldCount = userData.selectedProducts[product] ?? 0
    userData.selectedProducts[product] = oldCount + 1
  }
}

#if DEBUG
struct ProductItemView_Previews: PreviewProvider {

  private static let defaultProduct = Product(
    id: "1",
    title: "Brass knuckles",
    picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/9/92/Fo1_brass_knuckles.png")!,
    price: 220000
  )

  static var previews: some View {
    let userData = UserData()
    userData.selectedProducts[defaultProduct] = 0
    return ProductItemView(product: defaultProduct)
      .environmentObject(userData)
      .previewLayout(PreviewLayout.sizeThatFits)
      .padding()
  }
}
#endif
