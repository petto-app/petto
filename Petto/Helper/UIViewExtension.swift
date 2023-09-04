//
//  UIViewExtension.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import SwiftUI
import UIKit

extension UIView {
    // Enable preview for UIKit
    // source: https://dev.to/gualtierofr/preview-uikit-views-in-xcode-3543
    @available(iOS 13, *)

    struct View: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView

        func makeUIView(context _: Context) -> UIView {
            return view
        }

        func updateUIView(_: UIView, context _: Context) {
            //
        }
    }

    @available(iOS 13, *)
    func showView() -> View {
        // Inject self (the current UIView) for the preview
        View(view: self)
    }
}
