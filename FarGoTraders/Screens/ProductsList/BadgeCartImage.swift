//
//  BadgeButton.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import SwiftUI

struct BadgeCartImage: View {

  @EnvironmentObject
  var userData: UserData

  var body: some View {
    let count = userData.selectedProducts
      .compactMap { $0.value }
      .reduce(0, +)

    return ZStack {
      Image(systemName: "cart")
        .imageScale(.large)
        .accentColor(.blue)
        .disabled(count <= 0)

      if count > 99 {
        Badge(text: "...")
      } else if count > 0 {
        Badge(text: "\(count)")
      }
    }
  }
}

fileprivate struct Badge: View {

  let text: String

  var body: some View {
    Text(text)
      .frame(width: 20, height: 20)
      .font(Font.system(size: 12))
      .background(Color.red)
      .foregroundColor(.white)
      .clipShape(Circle())
      .offset(x: 12, y: -12)
  }
}

#if DEBUG
struct BadgeCartImage_Previews: PreviewProvider {

  private static let defaultProduct = Product(
    id: "1",
    title: "Brass knuckles",
    picture: URL(string: "https://static.wikia.nocookie.net/fallout/images/9/92/Fo1_brass_knuckles.png")!,
    price: 220000
  )

  static var previews: some View {
    let userData = UserData()
    userData.selectedProducts[defaultProduct] = 2
    return BadgeCartImage()
      .environmentObject(userData)
      .previewLayout(PreviewLayout.sizeThatFits)
      .padding()
  }
}
#endif
