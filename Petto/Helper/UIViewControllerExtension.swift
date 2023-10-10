//
//  UIViewControllerExtension.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import SwiftUI
import UIKit

extension UIViewController {
    // Enable preview for UIKit
    // source: https://fluffy.es/xcode-previews-uikit/
    @available(iOS 13, *)

    // Injecting the view controller
    struct View: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context _: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_: UIViewController, context _: Context) {
            //
        }
    }

    @available(iOS 13, *)
    func showView() -> View {
        View(viewController: self)
    }
}
