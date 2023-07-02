//
//  UIViewExtension.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import UIKit
import SwiftUI

extension UIView {
    // Enable preview for UIKit
    // source: https://dev.to/gualtierofr/preview-uikit-views-in-xcode-3543
    @available(iOS 13, *)
    
    struct View: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showView() -> View {
        // Inject self (the current UIView) for the preview
        View(view: self)
    }
}
