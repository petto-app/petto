//
//  UIViewControllerExtenstion.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import UIKit
import SwiftUI

extension UIViewController {
    // Enable preview for UIKit
    // source: https://fluffy.es/xcode-previews-uikit/
    @available(iOS 13, *)
    
    // Injecting the view controller
    struct View: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showView() -> View {
        View(viewController: self)
    }
}
