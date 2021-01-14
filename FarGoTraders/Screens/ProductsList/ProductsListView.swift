//
//  ProductsListView.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import SwiftUI

struct ProductsListView: View {

  @ObservedObject
  private var productsLoader = ProductsLoader()

  var body: some View {
    loaderWrapper
      .onAppear(perform: productsLoader.load)
      .onDisappear(perform: productsLoader.cancel)
  }

  private var loaderWrapper: some View {
    Group {
      if let products = productsLoader.products {
        LoadedProductsView(products: products)
          .environmentObject(UserData())
      } else {
        Text("Loading...")
      }
    }
  }
}

fileprivate struct LoadedProductsView: View {

  let products: [Product]

  @EnvironmentObject
  var userData: UserData

  var body: some View {
    let cartItemsCount = userData.selectedProducts
      .compactMap { $0.value }
      .reduce(0, +)

    return NavigationView {
      List {
        ForEach(products) { product in
          ProductItemView(product: product)
        }
      }
      .navigationBarTitle("Products list 🛍️")
      .navigationBarItems(trailing:
        NavigationLink(destination: CartView().environmentObject(userData)
      ) {
        BadgeCartImage().environmentObject(userData)
      }.disabled(cartItemsCount <= 0))
    }
  }
}

#if DEBUG
struct ProductsListView_Previews: PreviewProvider {

  private static let defaultProducts: [Product] = [
    Product(
      id: "1",
      title: "Brass knuckles",
      picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/9/92/Fo1_brass_knuckles.png")!,
      price: 220000
    ),
    Product(
      id: "2",
      title: "Power fist",
      picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/f/f1/Fo1_power_fist.png")!,
      price: 1450
    ),
    Product(
      id: "3",
      title: "Rock",
      picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/2/2f/FO1_Rock.gif")!,
      price: 0
    )
  ]

  static var previews: some View {
    LoadedProductsView(products: defaultProducts)
      .environmentObject(UserData())
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
#endif
