//
//  BMView.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/07/23.
//

import SwiftUI

protocol OnAppearDelegate: AnyObject {
    func updateBottomSheet(_ viewController: BMViewController)
}

struct BMView: UIViewControllerRepresentable {
    typealias UIViewControllerType = BMViewController
//    @Binding var bottomSheet: BottomSheet?
    @EnvironmentObject var bottomSheet: BottomSheet
    
    func makeUIViewController(context: Context) -> BMViewController {
        let vc = BMViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: BMViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
    
    func makeCoordinator() -> BMView.Coordinator {
        return Coordinator(self)
    }
}

struct BMView_Previews: PreviewProvider {
    static var previews: some View {
        BMView()
    }
}

extension BMView {
    class Coordinator: NSObject {
        var parent: BMView

        init(_ parent: BMView) {
            self.parent = parent
        }
        
        func viewWillAppear() {
            parent.bottomSheet.showSheet = false
        }
    }
}
