//
//  CartJsonResultModalView.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import SwiftUI

struct CartJsonResultModalView: View {

  @EnvironmentObject
  var userData: UserData

  @Environment(\.presentationMode)
  var presentationMode

  var body: some View {
    let cartState: [[String: Encodable]] = userData.selectedProducts
      .filter { $0.value > 0 }
      .map {
        [
          "id": $0.key.id,
          "title": $0.key.title,
          "amount": $0.value
        ]
      }

    let jsonData = try! JSONSerialization
      .data(withJSONObject: cartState,
            options: [.prettyPrinted])

    let jsonString = String(data: jsonData, encoding: .utf8)!
    return Text(jsonString)
      .onTapGesture {
        presentationMode.wrappedValue.dismiss()
      }
  }
}

#if DEBUG
struct CartJsonResultModalView_Previews: PreviewProvider {

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
    return CartJsonResultModalView()
      .environmentObject(userData)
  }
}
#endif
