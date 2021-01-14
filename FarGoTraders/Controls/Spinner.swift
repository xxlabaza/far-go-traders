//
//  Spinner.swift
//  FarGoTraders
//
//  Created by Artem Labazin on 13.01.2021.
//

import SwiftUI
import UIKit

struct Spinner: UIViewRepresentable {

  let isAnimating: Bool
  let style: UIActivityIndicatorView.Style

  func makeUIView (context: Context) -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(style: style)
    spinner.hidesWhenStopped = true
    return spinner
  }

  func updateUIView (_ uiView: UIActivityIndicatorView, context: Context) {
    isAnimating
      ? uiView.startAnimating()
      : uiView.stopAnimating()
  }
}
