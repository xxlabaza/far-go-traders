//
//  CartView.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import SwiftUI

struct CartView: View {

  @EnvironmentObject
  var userData: UserData

  @State
  var showBuyModal = false

  var body: some View {
    let products = userData.selectedProducts
      .sorted(by: { $0.key.id < $1.key.id })

    let totalPrice = products
      .map { (product, count) in product.price * count }
      .reduce(0, +)

    let totalPriceString = Product.formatDecimalString(for: totalPrice)

    return List {
      ForEach(products, id: \.key.id) { product, count in
        CartItemView(product: product)
          .environmentObject(userData)
      }
      .onDelete(perform: delete)
    }
    .navigationTitle("Cart items 🛒")
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Text(totalPriceString)
      }
      ToolbarItem(placement: .status) {
        buyButton
      }
    }
  }

  private var buyButton: some View {
    Button(action: { showBuyModal.toggle() }) {
      Text("Buy")
        .bold()
        .padding()
        .frame(minWidth: 999999, maxWidth: .infinity)
        .background(Color.green)
        .foregroundColor(.white)
    }
    .sheet(isPresented: $showBuyModal) {
      CartJsonResultModalView()
    }
  }

  private func delete (at offsets: IndexSet) {
    let products = userData.selectedProducts
      .keys
      .sorted(by: { $0.id < $1.id })

    offsets
      .map { products[$0] }
      .forEach { product in
        userData.selectedProducts.removeValue(forKey: product)
      }
  }
}

#if DEBUG
struct CartView_Previews: PreviewProvider {

  private static let defaultProducts: [Product: Int] = [
    Product(
      id: "1",
      title: "Brass knuckles",
      picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/9/92/Fo1_brass_knuckles.png")!,
      price: 220000
    ): 1,
    Product(
      id: "2",
      title: "Power fist",
      picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/f/f1/Fo1_power_fist.png")!,
      price: 1450
    ): 12,
    Product(
      id: "3",
      title: "Rock",
      picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/2/2f/FO1_Rock.gif")!,
      price: 0
    ): 2
  ]

  static var previews: some View {
    let userData = UserData()
    userData.selectedProducts = defaultProducts
    return CartView()
      .environmentObject(userData)
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
#endif
